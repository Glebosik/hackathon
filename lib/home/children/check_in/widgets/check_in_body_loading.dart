import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hackathon/gen/assets.gen.dart';
import 'package:hackathon/gen/colors.gen.dart';
import 'package:hackathon/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class CheckInBodyLoading extends StatelessWidget {
  const CheckInBodyLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Запись на консультирование',
          style: TextStyles.black18bold,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Орган контроля',
                style: TextStyles.black16,
              ),
              const SizedBox(height: 16),
              const DropDownShimmer(),
              const SizedBox(height: 24),
              Text(
                'Вид контроля',
                style: TextStyles.black16,
              ),
              const SizedBox(height: 16),
              const DropDownShimmer(),
              const SizedBox(height: 24),
              Text(
                'Тема консультирования',
                style: TextStyles.black16,
              ),
              const SizedBox(height: 16),
              const DropDownShimmer(),
              const SizedBox(height: 24),
              Text(
                'Дата и время',
                style: TextStyles.black16,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  style: ElevatedButtonTheme.of(context).style!.copyWith(
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)))),
                  onPressed: null,
                  child: const Text('Выбрать')),
              const SizedBox(height: 24),
              const Spacer(),
              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width * 0.9,
                          MediaQuery.of(context).size.height * 0.07),
                    ),
                    onPressed: null,
                    child: Text(
                      'Записаться на консультирование',
                      style: GoogleFonts.inter().copyWith(fontSize: 16),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropDownShimmer extends StatelessWidget {
  const DropDownShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorName.backgroundOrange,
        highlightColor: ColorName.orange,
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorName.backgroundOrange,
          ),
          child: DropdownButton(
            items: [
              DropdownMenuItem(
                  child: Text(
                '',
                style: TextStyles.black14,
                overflow: TextOverflow.ellipsis,
              ))
            ],
            onChanged: null,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Assets.icons.arrowDown.svg(height: 10),
          ),
        ));
  }
}
