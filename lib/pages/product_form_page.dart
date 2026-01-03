import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_project/models/product.dart';
import 'package:shop_project/models/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
    final _priceFocus = FocusNode();
    final _descriptionFocus = FocusNode();
    final _imageUrlFocus = FocusNode();
    final _imageUrlController = TextEditingController();

    final _globalKey = GlobalKey<FormState>();
    final _formData = Map<String, Object>();
  
  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if(_formData.isEmpty){
      final arg = ModalRoute.of(context)?.settings.arguments;

      if(arg != null){
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }
  
  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  void updateImage(){
    setState(() {});
  }

  bool isValidImageUrl(String url){
    bool isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFileExtension = 
      url.toLowerCase().endsWith('.png') ||
      url.toLowerCase().endsWith('.jpg') ||
      url.toLowerCase().endsWith('.jpeg') ||
      url.toLowerCase().endsWith('.webp');

    return isValid && endsWithFileExtension;
  }

  void submitForm(){
    final isValid = _globalKey.currentState?.validate() ?? false;

    if(!isValid){
      return;
    }

    _globalKey.currentState?.save();

    

    Provider.of<ProductList>(context, listen: false).addProductFromData(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de Produto'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: submitForm, 
            icon: Icon(Icons.save)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _globalKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name'] as String,
                decoration: InputDecoration(
                  labelText: 'Nome'
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                },
                onSaved: (newValue) => _formData['name'] = newValue ?? '-',
                validator: (value) {
                  final name = value ?? '';
                  if(name.trim().isEmpty) return 'O nome é obrigatório!';
                  if(name.trim().length < 3) return 'O nome precisa de pelo menos 3 letras!';
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: InputDecoration(
                  labelText: 'Preço'
                ),
                focusNode: _priceFocus,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (newValue) => _formData['price'] = newValue ?? '-',
                validator: (value) {
                  final priceString = value ?? '-1';
                  final price = double.tryParse(priceString) ?? -1;
                  if (price <= 0) return 'Informe um preço válido!';
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description'] as String,
                decoration: InputDecoration(
                  labelText: 'Descrição'
                ),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onSaved: (newValue) => _formData['description'] = newValue ?? '-',
                validator: (value){
                  final description = value ?? '';
                  if(description.trim().isEmpty) return 'A descrição é obrigatória!';
                  if(description.trim().length < 10) return 'A descrição precisa de pelo menos 10 letras!';
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'URL da imagem'
                      ),
                      focusNode: _imageUrlFocus,
                      controller: _imageUrlController,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => submitForm(),
                      onSaved: (newValue) => _formData['imageUrl'] = newValue ?? '-',
                      validator: (value){
                        final imageUrl = value ?? '';
                        
                        return isValidImageUrl(imageUrl) ? null : 'Informe uma URL válida!';
                      },
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.only(
                      top: 10,
                      left: 10
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1
                      )
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty ? 
                    Text('Informe a URL')
                    :
                    FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(_imageUrlController.text),
                    )
                    ,
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}