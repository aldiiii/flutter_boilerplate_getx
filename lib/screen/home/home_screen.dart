import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:starter_kit_app/controllers/home_controller.dart';
import 'package:starter_kit_app/data/models/category_model.dart';
import 'package:starter_kit_app/localizations.dart';
import 'package:starter_kit_app/utils/enums/app_state.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    final labels = AppLocalizations.of(context);

    return Container(
      child: DefaultTabController(
        length: 2,
        child: GetBuilder<HomeController>(
            id: 'menus-cetegory',
            initState: (_) => controller.fetchCategory(),
            builder: (state) {
              if (state.appState() == AppState.LOADING) {
                return Container(
                  color: Colors.black,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (state.appState() == AppState.ERROR) {
                return Center(
                    child: FlatButton(
                  child: Text(labels?.home?.loadAgain),
                  onPressed: () => controller.fetchCategory(),
                ));
              }
              return Stack(
                children: [
                  // content
                  TabBarView(
                    children: tabView(state.categoryState),
                  ),
                  // tab bar menu
                  SafeArea(
                    child: TabBar(
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: tabMarker(state.categoryState),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  tabMarker(List<CategoryModel> category) {
    List<Tab> tabs = List();
    for (int i = 0; i < category.length; i++) {
      tabs.add(Tab(
        text: category[i].name,
      ));
    }
    return tabs;
  }

  tabView(List<CategoryModel> category) {
    List<Widget> tabsView = List();
    for (int i = 0; i < category.length; i++) {
      tabsView.add(
        Container(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.categoryState[i].menus.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final MenuCategory data =
                  controller.categoryState[i].menus[index];
              return _buildContent(data);
            },
          ),
        ),
      );
    }
    return tabsView;
  }

  Widget _buildContent(MenuCategory data) {
    return CachedNetworkImage(
      imageUrl: data.image != null
          ? data.image
          : 'https://via.placeholder.com/400x700/000000/FFFFFF',
      errorWidget: (context, url, error) => Icon(Icons.error),
      imageBuilder: (context, imageProvider) => Container(
        width: Get.width,
        height: Get.height - 56,
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
        ),
        child: data.title != null && data.caption != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 73),
                    child: Text(
                      data.caption.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.7),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  OutlineButton(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 6),
                    borderSide: BorderSide(
                      color: Colors.white, //Color of the border
                      style: BorderStyle.solid, //Style of the border
                      width: 0.8, //width of the border
                    ),
                    child: Text(
                      'View',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {},
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
