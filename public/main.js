let currentPage = 1;
const itemsPerPage = 2;
const fragment = new DocumentFragment();
const url = '/tests';

// evento disparado qdo o doc HTML for completamente carregado e analisado
document.addEventListener('DOMContentLoaded', (event) => {
  // lista os dados do paciente
  function createListItem(patient) {
    const li = document.createElement('li');
    li.innerHTML = `      
      <h3>Token do exame: ${patient['token resultado exame']}</h3>
      <strong>Data do exame:</strong> ${new Date(patient['data exame']).toLocaleDateString('pt-BR')}
      <h3>Paciente</h3>
      <div class='data-patient'> 
        <strong>Nome:</strong> ${patient['nome paciente']} | 
        <strong>Data de Nascimento:</strong> ${new Date(patient['data nascimento paciente']).toLocaleDateString('pt-BR')} | 
        <strong>Endereço:</strong> ${patient['endereço/rua paciente']} | 
        <strong>Cidade:</strong> ${patient['cidade paciente']} | 
        <strong>Estado:</strong> ${patient['estado paciente']} 
      </div>
      <h3>Médico</h3>
      <div class='data-doctor'> 
        <strong>Nome:</strong> ${patient['nome médico']} |
        <strong>CRM/Estado:</strong> ${patient['crm médico']}/${patient['crm médico estado']} |
        <strong>Email:</strong> ${patient['email médico']}
      </div>
      <h3>Resultados</h3>
      <div class='result-exam'> 
        <ul>
          ${patient.exames.map(exame => `<li><strong>${exame['tipo exame']}:</strong><br> Limites: ${exame['limites tipo exame']} - Resultado:</strong>  ${exame['resultado tipo exame']}</li>`).join('')}
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
          throw new Error('Exame não encontrado');
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
