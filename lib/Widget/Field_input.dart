import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final bool enabled;
  final Function validator;
  final int maxline;
  final int maxlength;




  Input(
      {this.placeholder,
        this.suffixIcon,
        this.prefixIcon,
        this.onTap,
        this.onChanged,
        this.autofocus = false,
        this.controller,
        this.keyboardType,
        this.validator,
        this.maxline,
        this.maxlength,
        this.enabled = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
          validator: validator,
          onTap: onTap,
          maxLength: maxlength,
          maxLines: maxline,
          keyboardType:keyboardType ,
          onChanged: onChanged,
          controller: controller,
          autofocus: autofocus,
          enabled: true,

          style:
          TextStyle(height: 0.85, fontSize: 14, color: Colors.black),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
              filled: true,
              hintStyle: TextStyle(
                color: Color.fromRGBO(136, 152, 170, 1.0),
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
              hintText: placeholder)),
    );
  }
}
class Input2 extends StatelessWidget {
  final String placeholder;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final bool enabled;
  final Function validator;
  final int maxline;
  final int maxlength;




  Input2(
      {this.placeholder,
        this.suffixIcon,
        this.prefixIcon,
        this.onTap,
        this.onChanged,
        this.autofocus = false,
        this.controller,
        this.keyboardType,
        this.validator,
        this.maxline,
        this.maxlength,
        this.enabled = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
          onTap: onTap,
          maxLength: maxlength,
          maxLines: maxline,
          keyboardType:keyboardType ,
          onChanged: onChanged,
          controller: controller,
          autofocus: autofocus,
          enabled: true,

          style:Theme.of(context).textTheme.bodyText1.copyWith(fontSize: 16),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
              filled: true,
              labelStyle: TextStyle(
                color: Colors.white
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
              hintText: placeholder)),
    );
  }
}
class Input3 extends StatelessWidget {
  final String placeholder;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final Function onTap;
  final Function onChanged;
  final TextEditingController controller;
  final bool autofocus;
  final bool enabled;
  final Function validator;
  final int maxline;
  final int maxlength;




  Input3(
      {this.placeholder,
        this.suffixIcon,
        this.prefixIcon,
        this.onTap,
        this.onChanged,
        this.autofocus = false,
        this.controller,
        this.keyboardType,
        this.validator,
        this.maxline,
        this.maxlength,
        this.enabled = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(

          onTap: onTap,
          maxLength: maxlength,
          maxLines: maxline,
          keyboardType:keyboardType ,
          onChanged: onChanged,
          controller: controller,
          autofocus: autofocus,
          enabled: true,

          style: TextStyle(color: Colors.white),
          textAlignVertical: TextAlignVertical(y: 0.6),
          decoration: InputDecoration(
              filled: true,
              labelStyle: TextStyle(
                  color: Colors.white
              ),
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0, style: BorderStyle.solid)),
              hintText: placeholder)),
    );
  }
}