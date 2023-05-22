from _decimal import Decimal

from flask import Flask, render_template, request, redirect, url_for, session, flash
import pymysql
import re
from datetime import datetime
from decimal import Decimal
from reportlab.lib.pagesizes import letter
from reportlab.pdfgen import canvas


from flask_login import current_user, LoginManager, UserMixin

app = Flask(__name__)
app.secret_key = 'testing_grupo01'

# Configuración de la conexión a la base de datos MySQL
def connect():
    return pymysql.connect(
        host='localhost',
        password='Nomad18*',
        user='root',
        db='ucsm_farmacia',
        port=3306
    )

# Configuración de la ruta de imágenes de productos
app.config['PRODUCT_IMAGE_PATH'] = 'static/images/products/'

# Configuración de Flask-Login
login_manager = LoginManager(app)
login_manager.login_view = 'login'

# Clase de usuario para Flask-Login
class User(UserMixin):
    def __init__(self, id):
        self.id = id

@login_manager.user_loader
def load_user(user_id):
    return User(user_id)


# Funciones de validación de campos
def validar_nombre(nombre):
    patron = r'^[a-zA-ZÁÉÍÓÚáéíóúÜü](?:[a-zA-ZÁÉÍÓÚáéíóúÜü]*\s{0,1})*[a-zA-ZÁÉÍÓÚáéíóúÜü](?!\s)$'
    if re.match(patron, nombre):
        if '<' not in nombre and '>' not in nombre and '[' not in nombre and ']' not in nombre and '{' not in nombre \
                and '}' not in nombre:
            return True
    return False



def validar_dni(dni):
    patron = r'^\d{8}$'
    return re.match(patron, dni)

def validar_correo(correo):
    patron = r'^[\w\.-]+@[\w\.-]+\.(com|es)$'
    if re.match(patron, correo.strip()) and correo.count('.') == 1 and ' ' not in correo:
        if '<' not in correo and '>' not in correo and '[' not in correo and ']' not in correo and '{' not in correo and '}' not in correo:
            return True
    return False


def validar_contrasena(contrasena):
    patron = r'^(?!.*\s)(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{8,25}$'
    if re.match(patron, contrasena):
        if '<' not in contrasena and '>' not in contrasena and '[' not in contrasena and ']' not in contrasena and '{' not in \
                contrasena \
                and '}' not in contrasena:
            return True
    return False

# Ruta de inicio de sesión
@app.route('/', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        correo = request.form['correo']
        contrasena = request.form['contrasena']

        conn = connect()
        cursor = conn.cursor()
        cursor.execute("SELECT id_usuario, contrasena FROM usuarios WHERE correo = %s", (correo,))
        usuario = cursor.fetchone()
        cursor.close()
        conn.close()

        if usuario is None:
            flash('El usuario no existe. Verifica tus datos.', 'error')
            return redirect(url_for('login'))

        if contrasena == usuario[1]:
            session['usuario_id'] = usuario[0]
            flash('Inicio de sesión exitoso.', 'success')

            return render_template('sucursales.html')

        else:
            flash('Contraseña incorrecta. Verifica tus datos.', 'error')
            return redirect(url_for('login'))

    return render_template('login.html')

# Ruta de registro de usuario
@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        nombres = request.form['nombres']
        dni = request.form['dni']
        correo = request.form['correo']
        contrasena = request.form['contrasena']

        if validar_nombre(nombres) and validar_dni(dni) and validar_correo(correo) and validar_contrasena(contrasena):
            # Verificar si el DNI y correo ya están registrados
            conn = connect()
            cursor = conn.cursor()
            cursor.execute("SELECT dni, correo FROM usuarios WHERE dni = %s OR correo = %s", (dni, correo))
            resultado = cursor.fetchall()
            cursor.close()
            conn.close()

            if resultado:
                flash('El DNI o correo ya están registrados. Por favor, utiliza otros datos.', 'error')
                return redirect(url_for('registro'))

            # Realizar el registro si no hay duplicados
            conn = connect()
            cursor = conn.cursor()
            cursor.execute("INSERT INTO usuarios (nombres, dni, correo, contrasena) VALUES (%s, %s, %s, %s)",
                           (nombres, dni, correo, contrasena))
            conn.commit()
            cursor.close()
            conn.close()

            flash('Registro exitoso. Inicia sesión para continuar', 'success')
            return redirect(url_for('login'))
        else:
            if not validar_nombre(nombres):
                flash('Los nombres son inválidos. Verifica que no contenga caracteres prohibidos.', 'error')

            if not validar_dni(dni):
                flash('El DNI es inválido. Debe contener 8 dígitos numéricos.', 'error')

            if not validar_correo(correo):
                flash('El correo electrónico es inválido. Verifica que sea una dirección válida.', 'error')

            if not validar_contrasena(contrasena):
                flash('La contraseña es inválida. Verifica que cumpla con los requisitos.', 'error')

            return redirect(url_for('registro'))

    return render_template('registro.html')
# Ruta de selección de sucursal
@app.route('/sucursal')
def sucursal():
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

    cursor = connect().cursor()
    cursor.execute("SELECT id_sucursal FROM sucursales")
    sucursales = cursor.fetchall()
    cursor.close()

    return render_template('sucursales.html', sucursales=sucursales)

# Ruta de selección de categoría de productos
@app.route('/categorias', methods=['GET', 'POST'])
def categorias():
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

    id_sucursal = session.get('id_sucursal')  # Obtener el ID de la sucursal almacenado en la sesión

    if request.method == 'POST':
        categoria_seleccionada = request.form.get('categoria')
        if categoria_seleccionada:
            return redirect(url_for('productos', id_sucursal=id_sucursal, categoria=categoria_seleccionada))

    return render_template('categorias.html')

# Ruta de selección de productos
@app.route('/productos')
def productos():
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

    sucursal_id = request.args.get('sucursal_id')

    # Almacena el ID de la sucursal en la sesión
    session['id_sucursal'] = sucursal_id
    categoria = request.args.get('categoria')

    # Realizar la consulta SQL utilizando los valores de sucursal_id y categoria
    cursor = connect().cursor()

    if categoria:
        cursor.execute("SELECT p.nombre, p.descripcion, p.cantidad, p.precio FROM productos p INNER JOIN "
                       "inventario i ON p.id_producto = i.id_producto WHERE i.id_sucursal = %s AND p.categoria = %s",
                       (sucursal_id, categoria))
    else:
        cursor.execute("SELECT p.nombre, p.descripcion, p.cantidad, p.precio FROM productos p INNER "
                       "JOIN inventario i ON p.id_producto = i.id_producto WHERE i.id_sucursal = %s;",
                       (sucursal_id,))

    productos = cursor.fetchall()
    cursor.close()

    return render_template('productos.html', productos=productos)

# Ruta de facturación
@app.route('/factura', methods=['GET', 'POST'])
def factura():
    usuario_id = session.get('usuario_id')  # Obtener el ID del usuario almacenado en la sesión
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        fecha_actual = datetime.now().strftime('%d/%m/%Y')
        hora_actual = datetime.now().strftime('%H:%M')
        conn = connect()
        cursor = conn.cursor()

        productos_seleccionados = []
        subtotal = 0  # Variable para almacenar el subtotal

        for key, value in request.form.items():
            if key.startswith('cantidad_'):
                producto_id = key.split('_')[1]
                cantidad = int(value)

                if cantidad > 0:
                    # Obtener los datos del producto desde la base de datos
                    query = "SELECT u.nombres, u.dni, u.correo, p.nombre AS nombre_producto, p.precio, s.nombre AS " \
                            "nombre_sucursal, s.direccion, s.ciudad, s.pais FROM usuarios u, productos p, sucursales " \
                            "s WHERE p.id_producto = %s AND u.id_usuario = %s;"
                    cursor.execute(query, (producto_id, usuario_id))
                    producto = cursor.fetchone()

                    # Calcular el importe del producto y agregarlo al subtotal
                    importe = Decimal(cantidad) * producto[4]
                    subtotal += importe

                    # Agregar el producto y la cantidad a la lista de productos seleccionados
                    productos_seleccionados.append({
                        'nombres': producto[0],
                        'dni': producto[1],
                        'correo': producto[2],
                        'nombre_producto': producto[3],
                        'cantidad': cantidad,
                        'precio': producto[4],
                        'total': float(importe),
                        'nombre_sucursal': producto[5],
                        'direccion': producto[6],
                        'ciudad': producto[7],
                        'pais':producto[8],
                        'producto_id': producto_id
                    })

        cursor.close()
        conn.close()

        # Calcular impuesto y total
        impuesto = subtotal * Decimal('0.18')
        total = subtotal + impuesto
        # Antes de redirigir a la ruta '/guardar_factura', guarda los productos seleccionados en la sesión
        session['productos_seleccionados'] = productos_seleccionados

        # Renderizar la plantilla factura.html y pasar los datos seleccionados
        return render_template('factura.html', productos_seleccionados=productos_seleccionados,
                               fecha_actual=fecha_actual, hora_actual=hora_actual,
                               subtotal=subtotal, impuesto=impuesto, total=total)

    else:
        # Renderizar la plantilla factura.html para mostrar el formulario inicial
        return render_template('factura.html')


# Ruta para guardar la factura en la base de datos
@app.route('/guardar_factura', methods=['POST'])
def guardar_factura():
    usuario_id = session.get('usuario_id')  # Obtener el ID del usuario almacenado en la sesión
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        # Obtener los datos de la factura del formulario
        fecha_actual = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        nombre_cliente = request.form.get('nombre')
        dni_cliente = request.form.get('dni')
        correo_cliente = request.form.get('correo')
        productos_seleccionados = session.get('productos_seleccionados')

        # Calcular el subtotal, impuesto y total
        subtotal = sum(float(producto['total']) for producto in productos_seleccionados)
        impuesto = subtotal * 0.18
        total = subtotal + impuesto

        conn = connect()
        cursor = conn.cursor()

        # Insertar los datos de la factura en la tabla de facturas
        query = "SELECT id_producto FROM productos WHERE nombre = %s"
        cursor.execute(query, (productos_seleccionados[0]['nombre_producto']))
        id_producto = cursor.fetchone()[0]

        cursor.execute(
            'INSERT INTO factura (id_usuario, id_producto, fecha, subtotal, igv, total) '
            'VALUES (%s, %s, %s, %s, %s, %s)',
            (usuario_id, id_producto,fecha_actual, subtotal, impuesto, total)
        )

        # Guardar los cambios y cerrar la conexión a la base de datos
        conn.commit()
        conn.close()

        return render_template('confirmar_factura.html')

    return render_template('confirmar_factura.html')




# Ruta de búsqueda de facturas por DNI
@app.route('/buscar_factura', methods=['GET', 'POST'])
def buscar_factura():
    if 'usuario_id' not in session:
        return redirect(url_for('login'))

    if request.method == 'POST':
        dni = request.form['dni']

        cursor = connect().cursor()
        cursor.execute("SELECT * FROM facturas WHERE cliente_id = (SELECT id FROM usuarios WHERE dni = %s)", dni)
        facturas = cursor.fetchall()
        cursor.close()

        return render_template('facturas.html', facturas=facturas)

    return render_template('buscar_factura.html')

# Ruta de cierre de sesión
@app.route('/logout', methods=['POST'])
def logout():
    session.clear()
    return redirect(url_for('login'))


if __name__ == '__main__':
    app.run(port=3000, debug=True)
