import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/services/size_config.dart';


void main() {
  group('SizeConfig', () {
    late MediaQueryData mockMediaQueryData;

    setUp(() {
      mockMediaQueryData = const MediaQueryData(
        size: Size(1080, 1920),
        textScaleFactor: 1.2,
        padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
      );
    });

    testWidgets('init initializes screen dimensions correctly', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: mockMediaQueryData,
          child: Builder(
            builder: (context) {
              SizeConfig.init(context);

              expect(SizeConfig.screenWidth, 1080);
              expect(SizeConfig.screenHeight, 1920);
              expect(SizeConfig.aspectRatio, closeTo(1080 / 1920, 0.01));
              expect(SizeConfig.textScaleFactor, 1.2);
              expect(SizeConfig.safePaddingTop, 24.0);
              expect(SizeConfig.safePaddingBottom, 16.0);

              return Container();
            },
          ),
        ),
      );
    });

    test('percentWidth calculates width as a percentage of screen width', () {
      SizeConfig.screenWidth = 1080;

      expect(SizeConfig.percentWidth(50), 540);
      expect(SizeConfig.percentWidth(100), 1080);
      expect(SizeConfig.percentWidth(0), 0);
    });

    test('percentHeight calculates height as a percentage of screen height', () {
      SizeConfig.screenHeight = 1920;

      expect(SizeConfig.percentHeight(50), 960);
      expect(SizeConfig.percentHeight(100), 1920);
      expect(SizeConfig.percentHeight(0), 0);
    });

    test('scaledTextSize scales text size based on textScaleFactor', () {
      SizeConfig.textScaleFactor = 1.2;

      expect(SizeConfig.scaledTextSize(16), 16 * 1.2);
      expect(SizeConfig.scaledTextSize(20), 20 * 1.2);
    });

    test('safeAreaHeight calculates height adjusted for safe areas', () {
      SizeConfig.screenHeight = 1920;
      SizeConfig.safePaddingTop = 24.0;
      SizeConfig.safePaddingBottom = 16.0;

      expect(SizeConfig.safeAreaHeight(), 1920 - 24.0 - 16.0);
      expect(SizeConfig.safeAreaHeight(includeBottom: false), 1920 - 24.0);
    });

    test('sizeByAspectRatio adjusts size based on aspect ratio', () {
      SizeConfig.aspectRatio = 1080 / 1920;

      expect(SizeConfig.sizeByAspectRatio(100), closeTo(100 * (1080 / 1920), 0.01));
      expect(SizeConfig.sizeByAspectRatio(200), closeTo(200 * (1080 / 1920), 0.01));
    });

    testWidgets('safeAreaWidth calculates width accounting for horizontal safe area padding', (tester) async {
      await tester.pumpWidget(
        MediaQuery(
          data: const MediaQueryData(
            size: Size(1048, 1920),
            padding: EdgeInsets.symmetric(horizontal: 16.0),
          ),
          child: Builder(
            builder: (context) {
              SizeConfig.init(context);

              expect(SizeConfig.safeAreaWidth(), 1080 - 16.0 * 2);

              return Container();
            },
          ),
        ),
      );
    });
  });
}