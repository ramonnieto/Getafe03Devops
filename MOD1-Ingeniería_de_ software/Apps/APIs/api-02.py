from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

# Función para obtener el nombre del host
def get_hostname():
    try:
        return {'hostname': subprocess.check_output(['hostname'], text=True).strip()}
    except Exception as e:
        return {'error': str(e)}

# Función para obtener la información del kernel
def get_kernel():
    try:
        return {'kernel': subprocess.check_output(['uname', '-a'], text=True).strip()}
    except Exception as e:
        return {'error': str(e)}

# Función para obtener la información del CPU
def get_cpu_info():
    try:
        return {'cpu_info': subprocess.check_output(['lscpu'], text=True).strip()}
    except Exception as e:
        return {'error': str(e)}

# Endpoint para obtener el nombre del host
@app.route('/api/hostname', methods=['GET'])
def hostname():
    """
    Obtener el nombre del host.
    ---
    responses:
      200:
        description: Nombre del host obtenido exitosamente.
    """
    return jsonify(get_hostname())

# Endpoint para obtener la información del kernel
@app.route('/api/kernel', methods=['GET'])
def kernel():
    """
    Obtener la información del kernel.
    ---
    responses:
      200:
        description: Información del kernel obtenida exitosamente.
    """
    return jsonify(get_kernel())

# Endpoint para obtener la información del CPU
@app.route('/api/cpu', methods=['GET'])
def cpu():
    """
    Obtener la información del CPU.
    ---
    responses:
      200:
        description: Información del CPU obtenida exitosamente.
    """
    return jsonify(get_cpu_info())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
