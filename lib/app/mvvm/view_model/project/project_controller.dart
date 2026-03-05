import 'package:get/get.dart';

enum SortOption { name, date, size }

class ProjectController extends GetxController {
  var selectedSort = SortOption.name.obs;
  var isGridView = false.obs;

  void toggleView() {
    isGridView.value = !isGridView.value;
  }

   
  var todayProjects = [
    {
      'title': 'Untitled Project',
      'time': '10:10 AM',
      'image': 'assets/img1.png',
    },
    {
      'title': 'Untitled Project',
      'time': '09:30 AM',
      'image': 'assets/img2.png',
    },
  ].obs;

  var earlierProjects = [
    {
      'title': 'Untitled Project',
      'date': 'June 20, 2025',
      'image': 'assets/img3.png',
    },
    {
      'title': 'Untitled Project',
      'date': 'May 20, 2025',
      'image': 'assets/img4.png',
    },
    {
      'title': 'Untitled Project',
      'date': 'April 20, 2025',
      'image': 'assets/img5.png',
    },
    {
      'title': 'Untitled Project',
      'date': 'March 20, 2025',
      'image': 'assets/img6.png',
    },
  ].obs;

  void updateSort(SortOption option) {
    selectedSort.value = option;
  }
}
