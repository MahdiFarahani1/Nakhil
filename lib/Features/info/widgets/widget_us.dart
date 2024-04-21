import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/const/const_color.dart';
import 'package:flutter_application_1/Core/utils/esay_size.dart';
import 'package:flutter_application_1/Core/widgets/cubit/na_vcon_cubit.dart';
import 'package:flutter_application_1/Features/info/repository/aboutus_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getwidget/getwidget.dart';

class Btn {
  static Widget btnSocial(
      {required IconData iconData, required VoidCallback onPress}) {
    return GestureDetector(
      onTap: onPress,
      child: BlocBuilder<ControllerApp, NaVconState>(
        builder: (context, state) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: state.status is Araghi
                    ? ConstColor.baseColor
                    : ColorNakhil.item,
                borderRadius: BorderRadius.circular(4)),
            child: Icon(
              iconData,
              size: 20,
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  static Widget btncircle(
      {required IconData iconData,
      required double size,
      required VoidCallback onTap,
      required BuildContext context}) {
    return GFIconButton(
      size: size,
      iconSize: size,
      onPressed: onTap,
      shape: GFIconButtonShape.square,
      alignment: Alignment.center,
      icon: Icon(
        iconData,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      borderShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    );
  }

  static List<Widget> allbtn(BuildContext context) {
    return [
      Btn.btnSocial(
        iconData: FontAwesomeIcons.earthAmericas,
        onPress: () {
          BlocProvider.of<ControllerApp>(context).state.status is Araghi
              ? AboutRepository.launchUrl(AboutRepository.urlSiteAraghi)
              : AboutRepository.launchUrl(AboutRepository.urlSiteNews);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.instagram,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlInstagram);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.telegram,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlTelegram);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.youtube,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlYoutube);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.facebook,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlFacebook);
        },
      ),
      EsaySize.gap(10),
      Btn.btnSocial(
        iconData: FontAwesomeIcons.xTwitter,
        onPress: () {
          AboutRepository.launchUrl(AboutRepository.urlTwitter);
        },
      ),
    ];
  }
}
