let currentPage = 1;
const itemsPerPage = 1;
const fragment = new DocumentFragment();
const url = '/tests';

// evento disparado qdo o doc HTML for completamente carregado e analisado
document.addEventListener('DOMContentLoaded', (event) => {
  // lista os dados do paciente
  function createListItem(patient) {
    const li = document.createElement('li');
    li.innerHTML = `      
      <h4>Token do exame: ${patient['token resultado exame']}</h4>
      <strong>Data do exame:</strong> ${new Date(patient['data exame']).toLocaleDateString('pt-BR')}
      <h4>Dados do Paciente</h4>
      <div class='data-patient'> 
        <strong>Nome:</strong> ${patient['nome paciente']}<br> 
        <strong>Data de Nascimento:</strong> ${new Date(patient['data nascimento paciente']).toLocaleDateString('pt-BR')}<br>
        <strong>Endereço:</strong> ${patient['endereço/rua paciente']}, ${patient['cidade paciente']} - ${patient['estado paciente']} 
      </div>
      <h4>Dados do Médico</h4>
      <div class='data-doctor'> 
        <strong>Nome:</strong> ${patient['nome médico']}<br>
        <strong>CRM - Estado:</strong> ${patient['crm médico']} - ${patient['crm médico estado']}<br> 
        <strong>Email:</strong> ${patient['email médico']}
      </div>
      <h4>Resultados</h4>
      <div class='result-exam'> 
        <ul>
          ${patient.exames.map(exame => `<h4>${exame['tipo exame'].toUpperCase()}:</h4> 
          <ul><strong>Resultado:</strong>  ${exame['resultado tipo exame']} ------ <strong>Limites:</strong> ${exame['limites tipo exame']} </ul>`).join('')}
        </ul>
      </div>`;
    li.classList.add('item-exam');
    return li;
  }

  function displayPage(data, page) {
    const start = (page - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    const pageData = data.slice(start, end);
    
    // itera sobre cada paciente da pág.
    pageData.forEach(function(patient) {
      const li = createListItem(patient);
      fragment.appendChild(li);
    });

    document.querySelector('ul').innerHTML = '';
    document.querySelector('ul').appendChild(fragment);
  }

  // requisição GET para URL da API --> resposta JSON --> displayPage
  fetch(url).
    then((response) => response.json()).
    then((data) => {
      displayPage(data, currentPage);
    }).
    catch(function(error) {
      console.log(error);
    }); // se tiver um erro, ele é registrado no console

  // funções para clique nos botões de paginação
  document.getElementById('next-page').addEventListener('click', function() {
    currentPage++;
    fetch(url).
      then((response) => response.json()).
      then((data) => {
        displayPage(data, currentPage);
      }).
      catch(function(error) {
        console.log(error);
      });
  });

  document.getElementById('prev-page').addEventListener('click', function() {
    currentPage--;
    fetch(url).
      then((response) => response.json()).
      then((data) => {
        displayPage(data, currentPage);
      }).
      catch(function(error) {
        console.log(error);
      });
  });

  document.getElementById('search-button').addEventListener('click', function() {
    const token = document.getElementById('search-input').value;
    const url = `/tests/${token}`;
  
    console.log(`Fetching: ${url}`);
    
    fetch(url).
      then((response) => {
        if (!response.ok) {
          throw new Error('Exame não encontrado.');
        }
        return response.json();
      }).
      then((data) => {
        // Limpa lista e mostra o exame encontrado
        document.querySelector('ul').innerHTML = '';
        const li = createListItem(data);
        document.querySelector('ul').appendChild(li);
      }).
      catch(function(error) {
        console.log(error);
        // Mostra mensagem de erro
        document.querySelector('ul').innerHTML = '';
        const li = document.createElement('li');
        li.textContent = error.message;
        li.className = 'error-message'; 
        document.querySelector('ul').appendChild(li);
      });
  });
});
