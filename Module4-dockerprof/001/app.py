from flask import Flask, jsonify
import sqlite3
import random
import threading
import time

app = Flask(__name__)
DATABASE = "db.sqlite3"

# Función para inicializar la base de datos
def init_db():
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS readings (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tipo TEXT NOT NULL,
            valor REAL NOT NULL,
            timestamp DATETIME DEFAULT CURRENT_TIMESTAMP
        )
    """)
    conn.commit()
    conn.close()

# Función para insertar datos en la base de datos
def insert_reading(tipo, valor):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute("INSERT INTO readings (tipo, valor) VALUES (?, ?)", (tipo, valor))
    conn.commit()
    conn.close()

# Función para obtener los datos más recientes
def get_latest_reading(tipo):
    conn = sqlite3.connect(DATABASE)
    cursor = conn.cursor()
    cursor.execute("SELECT valor, timestamp FROM readings WHERE tipo = ? ORDER BY timestamp DESC LIMIT 1", (tipo,))
    result = cursor.fetchone()
    conn.close()
    return result

# Generar datos aleatorios cada 60 segundos
def generate_data():
    while True:
        pressure = round(random.uniform(900, 1100), 2)  # Presión entre 900 y 1100 hPa
        temperature = round(random.uniform(-10, 40), 2)  # Temperatura entre -10 y 40 °C
        humidity = round(random.uniform(0, 100), 2)  # Humedad entre 0% y 100%

        insert_reading("pressure", pressure)
        insert_reading("temperature", temperature)
        insert_reading("humidity", humidity)

        time.sleep(60)

# Rutas de la API
@app.route("/api/pressure", methods=["GET"])
def api_pressure():
    reading = get_latest_reading("pressure")
    if reading:
        return jsonify({"tipo": "presión", "valor": reading[0], "timestamp": reading[1]})
    return jsonify({"error": "No hay datos disponibles"}), 404

@app.route("/api/temperature", methods=["GET"])
def api_temperature():
    reading = get_latest_reading("temperature")
    if reading:
        return jsonify({"tipo": "temperatura", "valor": reading[0], "timestamp": reading[1]})
    return jsonify({"error": "No hay datos disponibles"}), 404

@app.route("/api/humidity", methods=["GET"])
def api_humidity():
    reading = get_latest_reading("humidity")
    if reading:
        return jsonify({"tipo": "humedad", "valor": reading[0], "timestamp": reading[1]})
    return jsonify({"error": "No hay datos disponibles"}), 404

# Inicializar la base de datos y comenzar a generar datos
if __name__ == "__main__":
    init_db()
    threading.Thread(target=generate_data, daemon=True).start()
    app.run(host="0.0.0.0", port=5000)
