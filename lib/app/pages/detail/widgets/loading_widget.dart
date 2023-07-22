import 'package:flutter/material.dart';
import 'package:go_watch/app/shared/widgets/margin_widget.dart';
import 'package:skeletons/skeletons.dart';

class LoadingWidget extends StatelessWidget {
const LoadingWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.65,
                    ),
                  ),
                  const MarginWidget(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: MediaQuery.of(context).size.width * 0.50,
                            height: 25,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const MarginWidget(
                          height: 15,
                        ),
                        Row(
                          children: [
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 20,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                            const MarginWidget(
                              width: 10,
                            ),
                            SkeletonLine(
                              style: SkeletonLineStyle(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: 20,
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),
                          ],
                        ),
                        const MarginWidget(
                          height: 30,
                        ),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: MediaQuery.of(context).size.width * 0.25,
                            height: 20,
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                        const MarginWidget(
                          height: 15,
                        ),
                        SkeletonParagraph(
                          style: SkeletonParagraphStyle(
                            lines: 4,
                            lineStyle: SkeletonLineStyle(
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
  }
}