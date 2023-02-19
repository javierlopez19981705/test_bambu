import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomImageNetwork extends StatelessWidget {
  const CustomImageNetwork(
      {required this.urlImage,
      this.boxFit = BoxFit.cover,
      this.width,
      this.height,
      super.key});

  final String? urlImage;
  final String errorImage =
      'https://firebasestorage.googleapis.com/v0/b/test-bambu.appspot.com/o/no-image.png?alt=media&token=a036962f-e465-4356-8210-df1a61077bcc';

  final BoxFit? boxFit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      urlImage ?? errorImage,
      // loadingBuilder: (context, child, loadingProgress) =>
      //     loadingProgress != null
      //         ? child
      //         : Image.asset(
      //             'assets/images/loading.gif',
      //           ),
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Image.asset(
          'assets/images/loading.gif',
          fit: boxFit,
          width: width,
          height: height,
        );
      },
      fit: boxFit,
      width: width,
      height: height,
    );
  }
}
