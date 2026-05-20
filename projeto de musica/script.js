const API_KEY = "AIzaSyAdWbMHbRu-ZjuNDFm731pw9SY9vOaR4hY";

async function gerarMusica(){

    let tema = document.getElementById("tema").value;

    let genero = document.getElementById("genero").value;

    let humor = document.getElementById("humor").value;

    let resultado = document.getElementById("resultado");

    resultado.innerHTML = "Gerando música... 🎵";

    const prompt = `
    Crie uma letra de música.

    Tema: ${tema}
    Gênero: ${genero}
    Humor: ${humor}

    Estruture em versos e refrão.
    `;

    const resposta = await fetch(
        `https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=${API_KEY}`,
        {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },

            body: JSON.stringify({
                contents: [
                    {
                        parts: [
                            {
                                text: prompt
                            }
                        ]
                    }
                ]
            })
        }
    );

    const dados = await resposta.json();

        console.log(dados);

            if (!dados.candidates) {
            resultado.innerHTML =
            "Erro ao gerar música 😭";
        return;
}

const texto =
dados.candidates[0].content.parts[0].text;

    resultado.innerHTML = `
    <h2>Música Gerada 🎵</h2>
    <p>${texto.replace(/\\n/g, "<br>")}</p>
    `;
}

window.gerarMusica = gerarMusica;
function novoRefrao(){

    let resultado =
    document.getElementById("resultado");

    resultado.innerHTML += `

    <h3>🎵 Novo Refrão</h3>

    <p>
    Gritos ecoam pela noite<br>
    Sombras queimam no coração<br>
    Mesmo perdido no vazio<br>
    Ainda existe redenção
    </p>
    `;
}

function maisTriste(){

    let resultado =
    document.getElementById("resultado");

    resultado.innerHTML += `

    <h3>💔 Versão Triste</h3>

    <p>
    A chuva cai sobre os sonhos<br>
    O silêncio tenta me consumir<br>
    Em cada passo da estrada<br>
    Só resta lembrar e partir
    </p>
    `;
}

function maisPoetico(){

    let resultado =
    document.getElementById("resultado");

    resultado.innerHTML += `

    <h3>✨ Versão Poética</h3>

    <p>
    Entre estrelas quebradas no céu<br>
    Minha alma dança na escuridão<br>
    Cada cicatriz guarda segredos<br>
    Escritos além da razão
    </p>
    `;
}
window.novoRefrao = novoRefrao;
window.maisTriste = maisTriste;
window.maisPoetico = maisPoetico;