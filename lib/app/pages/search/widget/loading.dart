import 'package:flutter/material.dart';
import 'package:go_watch/app/shared/widgets/margin_widget.dart';
import 'package:skeletons/skeletons.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const SkeletonLine(
                style: SkeletonLineStyle(
                  height: 180,
                  width: 120,
                ),
              ),
            ),
            const MarginWidget(
              width: 25,
            ),
            Expanded(
                child: Column(
              children: [
                const SkeletonLine(
                  style: SkeletonLineStyle(width: double.infinity, height: 20),
                ),
                const MarginWidget(
                  width: 10,
                ),
                SkeletonParagraph(
                  style: const SkeletonParagraphStyle(
                      lines: 5,
                      padding: EdgeInsets.all(0),
                      lineStyle: SkeletonLineStyle(
                          width: double.infinity, height: 15)),
                )
              ],
            ))
          ],
        );
      },
      separatorBuilder: (context, index) => const MarginWidget(
        height: 30,
      ),
      itemCount: 4,
    );
  }
}
