// ignore_for_file: use_key_in_widget_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'models/location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/location_tile.dart';
import 'styles.dart';

const BannerImageHeight = 300.0;
const BodyVerticalPadding = 20.0;
const FooterHeight = 100.0;

class LocationDetail extends StatefulWidget {
  final int locationID;

  const LocationDetail(this.locationID);

  @override
  createState() => _LocationDetailState();
}

class _LocationDetailState extends State<LocationDetail> {
  // final int locationID;
  Location location = Location.blank();

  // _LocationDetailState(this.locationID);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(location.name, style: Styles.navBarTitle)),
        body: Stack(children: [
          _renderBody(context, location),
          _renderFooter(context, location),
        ]));
  }

  loadData() async {
    final location = await Location.fetchByID(widget.locationID);

    if (mounted) {
      setState(() {
        this.location = location;
      });
    }
  }

  Widget _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(_bannerImage(location.url, BannerImageHeight));
    result.add(_renderHeader());
    result.addAll(_renderFacts(context, location));
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: result));
  }

  Widget _renderHeader() {
    return Container(
        padding: const EdgeInsets.symmetric(
            vertical: BodyVerticalPadding,
            horizontal: Styles.horizontalPaddingDefault),
        child: LocationTile(location: location, darkTheme: false));
  }

  Widget _renderFooter(BuildContext context, Location location) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration:
                BoxDecoration(color: Colors.white.withOpacity(0.5)),
            height: FooterHeight,
            child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: _renderFooterCTAButton()),
          )
        ]);
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = <Widget>[];
    for (int i = 0; i < (location.facts ?? []).length; i++) {
      result.add(_sectionTitle(location.facts![i].title));
      result.add(_sectionText(location.facts![i].text));
    }
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(
            Styles.horizontalPaddingDefault,
            25.0,
            Styles.horizontalPaddingDefault,
            0.0),
        child: Text(text.toUpperCase(),
            textAlign: TextAlign.left, style: Styles.headerLarge));
  }

  Widget _sectionText(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Text(text, style: Styles.textDefault));
  }

  Widget _bannerImage(String url, double height) {
    if (url.isEmpty) {
      return Container();
    }

    try {
      return Container(
        constraints: BoxConstraints.tightFor(height: height),
        child: Image.network(url, fit: BoxFit.fitWidth),
      );
    } catch (e) {
      print("could not load image $url");
      return Container();
    }
  }

  Widget _renderFooterCTAButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Styles.textColorBright,
        backgroundColor: Styles.accentColor,
      ),
      onPressed: _handleCTAPress,
      child: Text(
        "Book".toUpperCase(),
        style: Styles.textCTAButton,
      ),
    );
  }

  void _handleCTAPress() async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: 'somerandomfakeemail@randomEmail.co',
      queryParameters: {'subject': 'Inquiry'},
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
