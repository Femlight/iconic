import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/reports_bloc.dart';
import '../widgets/report_form.dart';

class CreateReportPage extends StatelessWidget {
  const CreateReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Report')),
      body: BlocListener<ReportsBloc, ReportsState>(
        listener: (context, state) {
          if (state is ReportCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Report created successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is ReportsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: const SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: ReportForm(),
        ),
      ),
    );
  }
}
