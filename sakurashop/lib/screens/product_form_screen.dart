import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
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
  var _isInit = true;
  var _isLoading = false;

  var _formProduct = Product(
    id: null,
    title: '',
    price: 0,
    imageUrl: '',
    description: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _formProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        _initValues = {
          'title': _formProduct.title,
          'description': _formProduct.description,
          'price': _formProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _formProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
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
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });

    if (_formProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_formProduct.id, _formProduct);
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_formProduct)
          .then((_) {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      });
    }
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
        borderRadius: BorderRadius.circular(3),
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _form,
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      initialValue: _initValues['title'],
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a value';
                        } else {
                          return null;
                        }
                      },
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
                          id: _formProduct.id,
                          isFavorite: _formProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initValues['price'],
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        if (double.parse(value) <= 0) {
                          return 'Please enter a number greater than zero.';
                        }
                        return null;
                      },
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
                          id: _formProduct.id,
                          isFavorite: _formProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      maxLines: 3,
                      initialValue: _initValues['description'],
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionFocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a description';
                        }
                        if (value.length <= 10) {
                          return 'Should be at least 10 characters long';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Description',
                      ),
                      onSaved: (value) {
                        _formProduct = Product(
                          title: _formProduct.title,
                          description: value,
                          price: _formProduct.price,
                          imageUrl: _formProduct.imageUrl,
                          id: _formProduct.id,
                          isFavorite: _formProduct.isFavorite,
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter an image URL';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _formProduct = Product(
                                title: _formProduct.title,
                                description: _formProduct.description,
                                price: _formProduct.price,
                                imageUrl: value,
                                id: _formProduct.id,
                                isFavorite: _formProduct.isFavorite,
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
