from flask import Flask, jsonify
import subprocess

app = Flask(__name__)

# Función para obtener información del sistema
def get_system_info():
    try:
        hostname = subprocess.check_output(['hostname'], text=True).strip()
        kernel = subprocess.check_output(['uname', '-a'], text=True).strip()
        cpu_info = subprocess.check_output(['lscpu'], text=True).strip()
        filesystem = subprocess.check_output(['df', '-TH'], text=True).strip()

        return {
            'hostname': hostname,
            'kernel': kernel,
            'cpu_info': cpu_info,
            'filesystem': filesystem
        }
    except Exception as e:
        return {'error': str(e)}

@app.route('/api/system_info', methods=['GET'])
def system_info():
    return jsonify(get_system_info())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
