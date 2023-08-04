// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'components/location_tile.dart';
import 'models/location.dart';
import 'location_detail.dart';
import 'styles.dart';

const ListItemHeight = 245.0;

class LocationList extends StatefulWidget {
  @override
  createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  List<Location> locations = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title:
                const Text("Locations", style: Styles.navBarTitle)),
        body: RefreshIndicator(
            onRefresh: loadData,
            child: Column(children: [
              renderProgressBar(context),
              Expanded(child: renderListView(context))
            ])));
  }

  Future<void> loadData() async {
    if (mounted) {
      setState(() => loading = true);
      Timer(const Duration(milliseconds: 3000), () async {
        final locations = await Location.fetchAll();
        setState(() {
          this.locations = locations;
          loading = false;
        });
      });
    }
  }

  Widget renderProgressBar(BuildContext context) {
    return (loading
        ? const LinearProgressIndicator(
            value: null,
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey))
        : Container());
  }

  Widget renderListView(BuildContext context) {
    return ListView.builder(
      itemCount: locations.length,
      itemBuilder: _listViewItemBuilder,
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    final location = locations[index];
    return GestureDetector(
        onTap: () => _navigateToLocationDetail(context, location.id),
        // ignore: sized_box_for_whitespace
        child: Container(
          height: ListItemHeight,
          child: Stack(children: [
            _tileImage(location.url,
                MediaQuery.of(context).size.width, ListItemHeight),
            _tileFooter(location),
          ]),
        ));
  }

  void _navigateToLocationDetail(
      BuildContext context, int locationID) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationDetail(locationID)));
  }

  Widget _tileImage(String url, double width, double height) {
    if (url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: const BoxConstraints.expand(),
        child: Image.network(url, fit: BoxFit.cover),
      );
    } catch (e) {
      // ignore: avoid_print
      print("could not load image $url");
      return Container();
    }
  }

  Widget _tileFooter(Location location) {
    final info = LocationTile(location: location, darkTheme: true);
    final overlay = Container(
      padding: const EdgeInsets.symmetric(
          vertical: 5.0, horizontal: Styles.horizontalPaddingDefault),
      decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
      child: info,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [overlay],
    );
  }

  Widget _itemTitle(Location location) {
    return Text(location.name, style: Styles.textDefault);
  }
}
