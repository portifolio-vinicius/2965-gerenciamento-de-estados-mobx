import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:panucci_delivery/components/item_list.dart';
import 'package:panucci_delivery/screens/checkout.dart';
import 'package:panucci_delivery/store/carrinho_store.dart';
import 'package:provider/provider.dart';
import '../components/categoria_text.dart';
import '../components/search_input.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  // por que usar usar TextEditingController em vez de criar um proprio?? qual o trade-off?
  //usar o TextEditingController é mais fácil e rápido, pois ele já tem métodos prontos para limpar o campo de busca, e para usar a validação do campo de busca,
  //caso queira implementar uma validação futura, enquanto criar um proprio controller seria mais trabalhoso e exigiria mais código,
  //além de não ter os métodos prontos para limpar o campo de busca e para usar a validação do campo de busca, caso queira implementar uma validação futura

  // como funciona                 child: SearchInput(searchTextController: searchTextController)), na pratica?
  //
  //o SearchInput é um widget que recebe o searchTextController como parâmetro, e o searchTextController
  //é usado para controlar o campo de busca, ou seja, para limpar o campo de busca quando o usuário clicar
  //no botão de limpar, e para usar a validação do campo de busca, caso queira implementar uma validação futura

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final carrinhoStore = Provider.of<CarrinhoStore>(context, listen: false);
    final BuildContext homeContext = context;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
                child: SearchInput(searchTextController: searchTextController)),
            const SliverToBoxAdapter(
                child: CategoriaText(titulo: "Mais comprados")),
            const SliverToBoxAdapter(
              child: ItemList(categoria: "mais comprados"),
            ),
            const SliverToBoxAdapter(
                child: CategoriaText(titulo: "Para o almoço")),
            const SliverToBoxAdapter(
              child: ItemList(categoria: "para o almoço"),
            ),
            const SliverToBoxAdapter(
                child: CategoriaText(titulo: "Para dividir")),
            const SliverToBoxAdapter(
              child: ItemList(categoria: "para dividir"),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Observer(
                  builder: (_) => !carrinhoStore.listaVazia
                      ? InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Checkout(homeContext: homeContext);
                            }));
                          },
                          child: Ink(
                              width: double.infinity,
                              height: 80,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).colorScheme.surfaceTint,
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10))),
                              child: Stack(children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "${carrinhoStore.quantidadeItem}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary),
                                        ),
                                      ),
                                      Icon(
                                        Icons.shopping_basket_outlined,
                                        size: 24,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                      )
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Ver carrinho",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "R\$ ${carrinhoStore.totalDaCompra.toStringAsFixed(2)}",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                  ),
                                ),
                              ])),
                        )
                      : Container(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
