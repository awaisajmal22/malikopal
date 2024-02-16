import 'package:flutter/material.dart';
import 'package:malikopal/bloc/dashboard_bloc.dart';
import 'package:malikopal/model/ReferenceInResponse.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';

class SearcData extends SearchDelegate {
  List<RefrenceInResponseData>? data;
  late DashboardBloc _bloc;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  List<RefrenceInResponseData> LoadData = [];

  @override
  Widget buildResults(BuildContext context) {
    // _bloc.GetReferenceInSink.add(LoadData);

    return StreamBuilder<ApiResponse<RefrenceInResponseData>>(
        stream: _bloc.GetReferenceInStream,
        builder: (context,
            AsyncSnapshot<ApiResponse<RefrenceInResponseData>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          ApiResponse<RefrenceInResponseData>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.data?.data?.referenceNodes?.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: CustomReferenceInCard(
                  name: data?.data?.data?.referenceNodes![index].fullName,
                  token_no: data?.data?.data?.referenceNodes![index].fullName,
                  icon: Icons.circle,
                  color: index % 2 == 0 ? Colors.red : Colors.transparent,
                  amount: data?.data?.data?.referenceNodes![index].toString(),
                ));
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search Data'),
    );
  }
}
