import 'package:url_launcher/url_launcher.dart';

class MapUtils {
  // MapUtils.named_() : this._();

  Future launchMap(String address) async {
    String query = Uri.encodeComponent(address);
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$query';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    }
    return googleUrl;
  }
}
