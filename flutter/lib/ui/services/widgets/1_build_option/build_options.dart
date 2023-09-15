import 'package:flutter/material.dart';

import '../../../../data/model/services/single_service_response.dart';
import 'widgets/1_build_subservice_selection.dart';
import 'widgets/2_build_billing_options.dart';
import 'widgets/5_build_how_it_works.dart';

class BuildServiceOptions extends StatefulWidget {
  final GetService service;

  const BuildServiceOptions(
      {Key? key, required this.service})
      : super(key: key);

  @override
  State<BuildServiceOptions> createState() => _BuildServiceOptionsState();
}

class _BuildServiceOptionsState extends State<BuildServiceOptions> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildSubServiceSelection(
          service: widget.service,
        ),
        // Frequency selector
        BuildBillingOptions(
          service: widget.service,
        ),

        // // //additional price section----
        // ...List.generate(widget.service.billingOptions.first.serviceAdditionalPayments.length,
        //     (index) => const BuildAdditionalPriceView()),

        // // Additional inputs section
        // BuildAdditionalInputsView(
        //   service: widget.service,
        // ),
        BuildHowItWorks(
          service: widget.service,
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height*.15,)
      ],
    );
  }
}
