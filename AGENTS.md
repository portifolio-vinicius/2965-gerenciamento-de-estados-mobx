# Diretrizes de Tipagem e Interfaces no Flutter

## 1. Segurança com Tipagem Forte
Garante que o compilador encontre erros antes mesmo de você rodar o aplicativo.

### Tipagem Explícita e Inferência
- **Tipos Primitivos:** Sempre prefira tipos claros (`int`, `double`, `String`, `bool`) a `var` em propriedades de classe.
- **Evite `dynamic`:** O uso de `dynamic` anula as verificações de segurança do Dart; use-o apenas se o dado for realmente imprevisível.

### Null Safety (Segurança de Nulo)
- **Operador `?`:** Define explicitamente se uma variável pode ser nula (ex: `String? nome`), forçando você a tratar o erro antecipadamente.
- **Operador `!`:** Use apenas quando tiver certeza absoluta de que o valor não é nulo, evitando o erro "Null check operator used on a null value".

## 2. Contratos através de Interfaces
No Dart, toda classe funciona como uma interface, permitindo definir "regras" para o seu código.

### Classes Abstratas (`abstract class`)
- **Definição de Contratos:** Servem como o esqueleto para outras classes, definindo métodos que precisam ser implementados sem conter a lógica em si.
- **Uso de `implements` vs `extends`:** Utilize `implements` quando quiser que uma classe siga um contrato estrito de uma interface, e `extends` quando quiser herdar comportamento base.

### Polimorfismo
- **Abstração de Implementação:** Programe para a interface, não para a classe concreta. Isso permite que você troque, por exemplo, um serviço de "API Real" por um "Mock de Teste" sem alterar a tela.

## 3. Tipagem em Coleções e Genéricos
Essencial para o gerenciamento de estados, como no seu `carrinho_store.dart`.

### Tipagem de Listas e Maps
- **Genéricos (`<T>`):** Em vez de usar apenas `List`, use `List<Item>`. Isso garante que o VS Code sugira propriedades do `Item` dentro de um `map` ou `forEach`.

### Tipagem no MobX/Stores
- **ObservableList e Observables:** Definir o tipo (ex: `ObservableList<Item>`) permite que o MobX gere o código `.g.dart` com precisão, facilitando o autocompletar e a detecção de mudanças.

## 4. Separação de Responsabilidades
Deve manter uma separação clara entre a construção das telas e componentes da lógica a ser executada.

### UI vs Lógica de Negócio
- **Telas e Componentes:** Foque apenas na apresentação e interação do usuário. Use widgets para renderizar dados e capturar eventos.
- **Lógica de Negócio:** Centralize em stores (como no MobX) ou serviços. Isso facilita testes, manutenção e reutilização.

### Benefícios
- **Manutenibilidade:** Mudanças na lógica não afetam a UI e vice-versa.
- **Testabilidade:** Teste a lógica separadamente da UI.
- **Reutilização:** Componentes podem ser reutilizados com diferentes lógicas.