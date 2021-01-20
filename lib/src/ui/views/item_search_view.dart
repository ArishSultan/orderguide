import 'package:unicons/unicons.dart';
import 'package:flutter/material.dart';
import 'package:orderguide/src/ui/widgets/text_field.dart';
import 'package:orderguide/src/ui/widgets/simple_future.dart';

typedef ItemBuilder<T> = Widget Function(BuildContext, T, int);
typedef ItemFetcher<T> = Future<List<T>> Function([String search]);

class ItemSearchViewController {
  _ItemSearchViewState _state;

  Future<void> refresh() => _state?._reFetchProducts();
}

class ItemSearchView<T> extends StatefulWidget {
  final ItemFetcher<T> onFetch;
  final ItemBuilder<T> builder;
  final ItemSearchViewController controller;

  final bool allowSearch;
  final String emptyMessage;
  final String searchMessage;
  final String noConnectionMessage;

  ItemSearchView({
    this.onFetch,
    this.builder,
    this.controller,
    this.allowSearch = true,
    this.emptyMessage = 'No Items Registered',
    this.searchMessage = 'Search Items',
    this.noConnectionMessage = 'No Connection',
  });

  @override
  _ItemSearchViewState<T> createState() => _ItemSearchViewState<T>();
}

class _ItemSearchViewState<T> extends State<ItemSearchView<T>> {
  // String search;
  Future<List<T>> _items;

  @override
  void initState() {
    super.initState();
    widget.controller._state = this;

    _reFetchProducts();
  }

  _reFetchProducts([String search]) {
    // if (search == null) search = '';
    _items = widget.onFetch(search);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      if (widget.allowSearch)
        SliverAppBar(
          floating: true,
          titleSpacing: 0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 13),
              child: AppTextField(
                // initialValue: search,
                icon: UniconsLine.search,
                placeholder: widget.searchMessage,
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (str) =>
                    setState(() => _reFetchProducts(str)),
              ),
            ),
          ),
        ),
      SimpleFutureBuilder<List<T>>(
        future: _items,
        errorBuilder: (context, error) {
          return SliverFillRemaining(
            child: Center(child: Text(error.toString())),
          );
        },
        unknownBuilder: (context) => SliverFillRemaining(
            child: Center(child: Text(widget.noConnectionMessage))),
        loadingBuilder: (context, _) => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator())),
        builder: (context, List<T> items) {
          if (items.isEmpty) {
            return SliverFillRemaining(
                child: Center(child: Text(widget.emptyMessage)));
          } else {
            return SliverPadding(
              padding: const EdgeInsets.only(top: 10),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      widget.builder(context, items[index], index),
                  childCount: items.length,
                ),
              ),
            );
          }
        },
      )
    ]);
  }
}
