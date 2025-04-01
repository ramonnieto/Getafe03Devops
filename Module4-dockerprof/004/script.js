// Función para realizar una solicitud GET a la API
async function fetchSensorData(endpoint) {
  const baseUrl = "https://192.168.33.10/api";
  const url = `${baseUrl}/${endpoint}`;

  try {
    const response = await fetch(url);
    if (!response.ok) {
      throw new Error(`Error al consultar ${endpoint}: ${response.status}`);
    }
    const data = await response.json();
    return data;
  } catch (error) {
    console.error(error);
    return { error: error.message };
  }
}

// Función para actualizar el resultado en la página
function updateResults(data) {
  const resultText = document.getElementById("result-text");

  if (data.error) {
    resultText.innerHTML = `<strong>Error:</strong> ${data.error}`;
    return;
  }

  // Formatear los datos en HTML legible
  resultText.innerHTML = `
    <strong>Tipo:</strong> ${data.tipo}<br>
    <strong>Valor:</strong> ${data.valor}<br>
    <strong>Última actualización:</strong> ${data.timestamp}
  `;
}

// Asignar eventos a los botones
document.getElementById("pressure-btn").addEventListener("click", async () => {
  const data = await fetchSensorData("pressure");
  updateResults(data);
});

document.getElementById("temperature-btn").addEventListener("click", async () => {
  const data = await fetchSensorData("temperature");
  updateResults(data);
});

document.getElementById("humidity-btn").addEventListener("click", async () => {
  const data = await fetchSensorData("humidity");
  updateResults(data);
});
