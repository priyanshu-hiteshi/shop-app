// Image.network(
//         widget.product.thumbnail,
//         loadingBuilder: (context, child, loadingProgress) {
//           if (loadingProgress != null) {
//             return Container(
//                 height: 40,
//                 width: 40,
//                 alignment: Alignment.center,
//                 child: CircularProgressIndicator());
//           }
//           return child;
//         },
//         errorBuilder: (context, error, stackTrace) {
//           return Icon(Icons.error);
//         },
//       ),