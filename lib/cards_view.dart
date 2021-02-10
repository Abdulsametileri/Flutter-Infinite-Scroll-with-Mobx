import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:infinite_scroll/cards_view_model.dart';

import 'card_item_view.dart';

class CardsView extends StatefulWidget {
  @override
  _CardsViewState createState() => _CardsViewState();
}

class _CardsViewState extends State<CardsView> {
  CardsViewModel _vm;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _vm = CardsViewModel();
    _vm.init();
    _vm.fetchCards();

    _addScrollListener();

    super.initState();
  }

  void _addScrollListener() {
    _scrollController.addListener(() {
      bool isUserScrollAtBottomOfThePage = _scrollController.offset >= _scrollController.position.maxScrollExtent;
      if (isUserScrollAtBottomOfThePage) {
        _vm.fetchCards();
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cards'),
      ),
      body: Observer(builder: (_) {
        if (_vm.cards.isEmpty) {
          return _buildLoading;
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          controller: _scrollController,
          itemCount: _vm.cards.length + 1,
          itemBuilder: (context, index) {
            if (index == _vm.cards.length) {
              return _buildLoading;
            }

            return CardItemView(card: _vm.cards[index]);
          },
        );
      }),
    );
  }

  Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
