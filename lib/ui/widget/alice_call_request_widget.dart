import 'package:alice/model/alice_http_call.dart';
import 'package:alice/ui/widget/alice_base_call_details_widget.dart';
import 'package:flutter/material.dart';

class AliceCallRequestWidget extends StatefulWidget {
  final AliceHttpCall call;

  const AliceCallRequestWidget(this.call)
      : assert(call != null, "call can't be null");

  @override
  State<StatefulWidget> createState() {
    return _AliceCallRequestWidget();
  }
}

class _AliceCallRequestWidget
    extends AliceBaseCallDetailsWidgetState<AliceCallRequestWidget> {
  AliceHttpCall get _call => widget.call;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];
    rows.add(getListRow("Started:", _call.request.time.toString()));
    rows.add(getListRow("Bytes sent:", formatBytes(_call.request.size)));
    rows.add(
        getListRow("Content type:", getContentType(_call.request.headers)));

    final dynamic body = _call.request.body;
    var bodyContent = "Body is empty";
    if (body != null) {
      bodyContent = formatBody(body, getContentType(_call.request.headers));
    }
    rows.add(getListRow("Body:", bodyContent));
    final formDataFields = _call.request.formDataFields;
    if (formDataFields?.isNotEmpty == true) {
      rows.add(getListRow("Form data fields: ", ""));
      formDataFields.forEach(
        (field) {
          rows.add(getListRow("   • ${field.name}:", field.value));
        },
      );
    }
    final formDataFiles = _call.request.formDataFiles;
    if (formDataFiles?.isNotEmpty == true) {
      rows.add(getListRow("Form data files: ", ""));
      formDataFiles.forEach(
        (field) {
          rows.add(getListRow("   • ${field.fileName}:",
              "${field.contentType} / ${field.length} B"));
        },
      );
    }

    final headers = _call.request.headers;
    var headersContent = "Headers are empty";
    if (headers != null && headers.isNotEmpty) {
      headersContent = "";
    }
    rows.add(getListRow("Headers: ", headersContent));
    if (_call.request.headers != null) {
      _call.request.headers.forEach((header, dynamic value) {
        rows.add(getListRow("   • $header:", value.toString()));
      });
    }
    final queryParameters = _call.request.queryParameters;
    var queryParametersContent = "Query parameters are empty";
    if (queryParameters != null && queryParameters.isNotEmpty) {
      queryParametersContent = "";
    }
    rows.add(getListRow("Query Parameters: ", queryParametersContent));
    if (_call.request.queryParameters != null) {
      _call.request.queryParameters.forEach((query, dynamic value) {
        rows.add(getListRow("   • $query:", value.toString()));
      });
    }

    return Container(
      padding: const EdgeInsets.all(6),
      child: ListView(children: rows),
    );
  }
}
