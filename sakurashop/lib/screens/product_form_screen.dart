import 'package:flutter/material.dart';
import '../providers/product.dart';
import '../ui/sakura_bar.dart';

class ProductFormScreen extends StatefulWidget {
  static const route = '/product-form';

  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _form = GlobalKey<FormState>();
  var _formProduct = Product(
    id: null,
    title: '',
    price: 0,
    imageUrl: '',
    description: '',
  );

  @override
  void initState() {
    _imageUrlFocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocus.removeListener(_updateImageUrl);
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    _form.currentState.save();
    
  }

  Widget _imagePreviewBox() {
    var placeholder = Center(
      child: Icon(
        Icons.image,
        size: 16,
        color: Colors.grey,
      ),
    );

    var image = FittedBox(
      child: Image.network(
        _imageUrlController.text,
        fit: BoxFit.cover,
      ),
    );

    return Container(
      width: 48,
      height: 48,
      margin: EdgeInsets.only(top: 15, right: 15),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.grey),
      ),
      child: _imageUrlController.text.isEmpty ? placeholder : image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: SakuraBar(
          title: 'Edit Product',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (value) {
                  _formProduct = Product(
                    title: value,
                    description: _formProduct.description,
                    price: _formProduct.price,
                    imageUrl: _formProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                focusNode: _priceFocus,
                decoration: InputDecoration(
                  labelText: 'Price',
                ),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (value) {
                  _formProduct = Product(
                    title: _formProduct.title,
                    description: _formProduct.description,
                    price: double.parse(value),
                    imageUrl: _formProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              TextFormField(
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onSaved: (value) {
                  _formProduct = Product(
                    title: _formProduct.title,
                    description: value,
                    price: _formProduct.price,
                    imageUrl: _formProduct.imageUrl,
                    id: null,
                  );
                },
              ),
              Row(
                children: <Widget>[
                  _imagePreviewBox(),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      textInputAction: TextInputAction.done,
                      focusNode: _imageUrlFocus,
                      onSaved: (value) {
                        _formProduct = Product(
                          title: _formProduct.title,
                          description: _formProduct.description,
                          price: _formProduct.price,
                          imageUrl: value,
                          id: null,
                        );
                      },
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 0,
                  color: Colors.indigo,
                  textColor: Colors.white,
                  child: Text('SAVE'),
                  onPressed: _saveForm,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
