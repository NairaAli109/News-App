// ignore_for_file: avoid_types_as_parameter_names
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:news_app/screens/web_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget defaultTextFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  onChange,
  onTap,
  bool isPassword= false,
  required String? Function(String?) validator,
  required String label,
  required IconData preIcon,
  IconData? suffIcon,
  Function? suffixPressed,
  bool isClickable= true,
})=>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validator,
      decoration:  InputDecoration(
          labelText: label,
          prefixIcon: Icon(preIcon),
          suffixIcon: suffIcon != null
              ? IconButton(
              onPressed: suffixPressed!(),
              icon: Icon(suffIcon)
          )
          :null,
          border: const OutlineInputBorder()),
    );

void navigateTo(context,widget)=> Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context)=>widget,
    )
);

Widget buildArticleItem(article, context)=>  InkWell(
  onTap: (){

    final WebViewController controller= WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(article['url']));

    navigateTo(context, WebViewScreen(controller));
  },
  child: Padding(
    padding: const EdgeInsets.all(20),
    child: Row(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:  DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit:BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20,),
        Expanded(
            child: SizedBox(
              height: 120,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child:Text(
                      "${article['title']}",
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 3,
                      overflow:TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${article['publishedAt']}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
        ),
      ],
    ),
  ),
);

Widget myDivider()=>const Divider(thickness: 2,);

Widget articleBuilder(list,context , {isSearch=false})=>ConditionalBuilder(
  condition: list.isNotEmpty,
  builder: (context) =>ListView.separated(
    physics: const BouncingScrollPhysics(),
    itemCount:list.length ,
    itemBuilder: (context, index)=> buildArticleItem(
      list[index],
      context
    ),
    separatorBuilder: (context,index)=>myDivider(),
  ),
  fallback: (context) => isSearch ? Container() : const Center(
    child: CircularProgressIndicator(),
  ),
);