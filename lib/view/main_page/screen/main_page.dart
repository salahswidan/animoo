import 'package:animoo/core/resources/colors_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../controller/main_page_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  late MainPageController _mainPageController;
  @override
  void initState() {
    super.initState();
    _mainPageController = MainPageController(context);
  }

  @override
  void dispose() {
    _mainPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<int>(
      initialData: 0,
      stream: _mainPageController.currentIndexOutputStream,
      builder: (context, snapshot) {
        return Scaffold(
          body: PageView(
            onPageChanged: _mainPageController.onPageChangedOfPageView,
            controller: _mainPageController.pageController,
            children: [
              for (int i = 0; i < _mainPageController.pages.length; i++)
                _mainPageController.hasVisited[i]
                    ? _mainPageController.buildWidget(i)
                    : (snapshot.data == i
                        ? _mainPageController.buildWidget(i)
                        : Container()),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _mainPageController.onTapBottomNavigationBarItem,
            currentIndex: snapshot.data ?? 0,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: ColorManager.kWhite2Color,
            selectedItemColor: ColorManager.kPrimaryColor,
            selectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.kPrimaryColor,
            ),
            unselectedItemColor: ColorManager.kGrey6Color,
            unselectedLabelStyle: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: ColorManager.kGrey6Color,
            ),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart_fill),
                label: 'Animals',
              ),

              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
            ],
          ),
        );
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
