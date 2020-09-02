import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.canvasColor,
        elevation: 0,
        leading: FlatButton(
          shape: CircleBorder(),
          child: Icon(Icons.arrow_back),
          onPressed: Get.back,
        ),
        // title: Text(
        //   'About App',
        //   style: TextStyle(
        //     color: Get.theme.textTheme.bodyText1.color,
        //   ),
        // ),
        // title: Text(
        //   'IMAZINE',
        //   style: TextStyle(
        //     fontFamily: 'strasua',
        //     fontSize: 20,
        //     color: Colors.amber,
        //     fontWeight: FontWeight.w900,
        //   ),
        // ),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.fromLTRB(15, 35, 15, 25),
          children: [
            Center(
              child: Text(
                'IMAZINE',
                style: TextStyle(
                  fontFamily: 'strasua',
                  fontSize: 32.5,
                  color: Colors.amber,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 5),
            Center(
              child: Text(
                'Version 2.0.1',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Himatif Imazine (Informatics Magazine) Apps merupakan sebuah platform media yang menyajikan sebuah artikel terkait bidang teknologi informasi, berita dunia, fakta unik dan menarik, serta menyajikan rangkaian informasi program kerja di Badan Eksekutif Himatif FMIPA Unpad.\n\n'
                'Dengan berbagai perubahan untuk versi saat ini, diharapkan memberikan kemudahan untuk khalayak umum mendapatkan sebuah informasi yang terbaru.',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  height: 1.65,
                ),
              ),
            ),
            SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'OUR SOCIAL MEDIA',
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 15),
            buildSocialMediaBtn(
              FontAwesomeIcons.instagram,
              'himatifunpad',
              () => openLink('https://www.instagram.com/himatifunpad'),
              Colors.redAccent,
            ),
            buildSocialMediaBtn(
              FontAwesomeIcons.line,
              'himatifunpad',
              () => openLink('http://line.me/ti/p/~@himatifunpad'),
              Colors.green,
            ),
            buildSocialMediaBtn(
              FontAwesomeIcons.twitter,
              'himatifunpad',
              () => openLink('https://twitter.com/HimatifUnpad'),
              Colors.lightBlueAccent,
            ),
            Divider(
              thickness: 1,
              indent: 10,
              endIndent: 10,
              height: 25,
            ),
            buildSocialMediaBtn(
              FontAwesomeIcons.globeAsia,
              'himatif.fmipa.unpad.ac.id',
              () => openLink('http://himatif.fmipa.unpad.ac.id'),
            ),
            buildSocialMediaBtn(
              FontAwesomeIcons.envelope,
              'himatifunpad@gmail.com',
              () => openLink('mailto:himatifunpad@gmail.com'),
            ),
          ],
        ),
      ),
    );
  }

  void openLink(String link) async {
    // final String url =
    //     "https://www.google.com/maps/search/?api=1&query=${query}";

    final String encodedURl = Uri.encodeFull(link);

    if (await canLaunch(encodedURl)) {
      await launch(encodedURl);
    } else {
      print('Could not launch $encodedURl');
      throw 'Could not launch $encodedURl';
    }
  }

  FlatButton buildSocialMediaBtn(
      IconData iconData, String title, Function onPressed,
      [colors]) {
    return FlatButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.5)),
      padding: EdgeInsets.all(12.5),
      onPressed: onPressed,
      child: Row(
        children: [
          FaIcon(
            iconData,
            color: colors ?? Colors.grey,
          ),
          SizedBox(width: 25),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 15,
          ),
        ],
      ),
    );
  }
}
