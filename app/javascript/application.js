// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "chart.js"
import adapter from "chartjs-adapter-date-fns";




document.addEventListener('turbo:load', function () {
  const tipoSelect = document.querySelector('[name="document_type"]');
  const extraField = document.getElementById('extra-field');

  if (tipoSelect && extraField) {
    tipoSelect.addEventListener('change', function () {

      const tipo = this.value;
      let html = '';

      if (tipo === 'frequencia') {
        // --- INÍCIO DO BLOCO DE CÓDIGO ALTERADO ---
        html = `
              <div class="mb-4">
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Nome do Professor(a)</label>
              <input type="text" name="professor" class="form-input w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600" />
              </div>
              <div class="mb-4">
            <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Mês</label>
            <select name="month" class="form-select w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600">
              <option value="">Selecione um mês</option>
              <option value="Janeiro">Janeiro</option>
              <option value="Fevereiro">Fevereiro</option>
              <option value="Março">Março</option>
              <option value="Abril">Abril</option>
              <option value="Maio">Maio</option>
              <option value="Junho">Junho</option>
              <option value="Julho">Julho</option>
              <option value="Agosto">Agosto</option>
              <option value="Setembro">Setembro</option>
              <option value="Outubro">Outubro</option>
              <option value="Novembro">Novembro</option>
              <option value="Dezembro">Dezembro</option>
            </select>
          </div>
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Disciplina</label>
            <input type="text" name="discipline" class="form-input w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600" />
          </div>
        `;
        // --- FIM DO BLOCO DE CÓDIGO ALTERADO ---
      } else if (tipo === 'notas') {
        // --- INÍCIO DO BLOCO DE CÓDIGO SUGERIDO ---
        html = `
              <div class="mb-4">
              <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Nome do Professor(a)</label>
              <input type="text" name="professor" class="form-input w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600" />
              </div>
          <div class="mb-4">
            <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Bimestre</label>
            <select name="bimestre" class="form-select w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600">
              <option value="">Selecione o bimestre</option>
              <option value="1º Bimestre">1º Bimestre</option>
              <option value="2º Bimestre">2º Bimestre</option>
              <option value="3º Bimestre">3º Bimestre</option>
              <option value="4º Bimestre">4º Bimestre</option>
            </select>
          </div>
          <div>
            <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Disciplina</label>
            <input type="text" name="discipline" class="form-input w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600" />
          </div>
          
        `;
        // --- FIM DO BLOCO DE CÓDIGO SUGERIDO ---
      } else if (tipo === 'pauta') {
        html = `
    <label class="block mb-1 text-sm font-medium text-gray-700 dark:text-gray-300">Descrição do Evento</label>
    <input type="text" name="descricao" value=" (${new Date().toLocaleDateString('pt-BR')})" class="form-input w-full px-4 py-2 border rounded-md dark:bg-gray-700 dark:text-white dark:border-gray-600" />
  `;
      }

      extraField.innerHTML = html;
    });
  }

  
  
});

