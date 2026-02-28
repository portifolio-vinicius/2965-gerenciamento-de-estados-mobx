import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({Key? key, required this.searchTextController})
      : super(key: key);
  final TextEditingController searchTextController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      // por que usar TextFormField? para usar o controller, que é necessário para limpar o campo de busca
      // quando o usuário clicar no botão de limpar, e para usar a validação do campo de busca, caso queira implementar uma validação futura
      child: TextFormField(
        controller: searchTextController,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(8.0),
          constraints: BoxConstraints(maxHeight: 45),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          hintText: "Buscar um item",
          prefixIcon: Icon(Icons.search),
        ),
      ),
    );
  }
}
