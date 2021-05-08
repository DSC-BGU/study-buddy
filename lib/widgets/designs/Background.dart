import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:study_buddy/utils/HexColor.dart';

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
      return Stack(
        children: [
          Container(
            color: HexColor("#5CA2D5"),
          ),
          Column(
            children: [
              Container(
                height:constraints.maxHeight * 0.4,
                decoration: BoxDecoration(
                  color: HexColor("#91CCF4"),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
              Container(
                height: constraints.maxHeight * 0.6,
                child: Stack(
                  children: [
                    Container(
                      child: SvgPicture.string(
                        '<svg viewBox="-32.6 331.2 487.2 597.4" ><path transform="matrix(0.325568, -0.945519, 0.945519, 0.325568, -32.59, 818.62)" d="M 133.9144439697266 4.958671092987061 C 68.59900665283203 12.76398086547852 3.221581220626831 80.36195373535156 0.115386001765728 152.5227966308594 C -3.648317575454712 239.9583435058594 85.49879455566406 299.5778503417969 144.0722503662109 321.3473815917969 C 281.8222351074219 372.5464477539063 474.8547058105469 297.8077392578125 509.3921203613281 180.7661285400391 C 529.8274536132813 111.5174255371094 496.9800415039063 19.99903297424316 441.7923583984375 2.737515449523926 C 391.4920043945313 -12.99513721466064 359.2218627929688 44.40321350097656 270.5155334472656 40.18292999267578 C 199.6452331542969 36.81270980834961 187.1434631347656 -1.400654911994934 133.9144439697266 4.958671092987061 Z" fill="#91ccf4" fill-opacity="0.4" stroke="none" stroke-width="1" stroke-opacity="0.4" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: false,
                      ),
                    ),
                    Container(
                      child: SvgPicture.string(
                        '<svg viewBox="-105.1 292.9 601.1 605.4" ><path transform="matrix(0.694658, -0.71934, 0.71934, 0.694658, -105.09, 663.71)" d="M 133.9144592285156 4.958680152893066 C 68.59900665283203 12.76399612426758 3.221582174301147 80.36199188232422 0.115381047129631 152.5228118896484 C -3.648329019546509 239.9583740234375 85.49878692626953 299.5779113769531 144.0722351074219 321.3474731445313 C 281.8222351074219 372.5465393066406 474.8547668457031 297.8077697753906 509.39208984375 180.7661285400391 C 529.8275146484375 111.5174255371094 496.9800720214844 19.99901008605957 441.7923889160156 2.737499237060547 C 391.4920043945313 -12.99515151977539 359.2218627929688 44.40321350097656 270.5155639648438 40.18293380737305 C 199.6452484130859 36.81270980834961 187.1434783935547 -1.4006507396698 133.9144592285156 4.958680152893066 Z" fill="#91ccf4" fill-opacity="0.15" stroke="none" stroke-width="1" stroke-opacity="0.15" stroke-miterlimit="10" stroke-linecap="butt" /></svg>',
                        allowDrawingOutsideViewBox: true,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      );
    });
  }
}
