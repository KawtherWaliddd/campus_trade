import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/SellScreen/presentation/cubit/AddData_State.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Upload/Cubit/UploadCubit_State.dart';
import '../../../Upload/Cubit/UploadCubit_class.dart';
import '../cubit/AddData_Class.dart';
import '../cubit/TestProduct.dart';
import '../../../product/presentaion/home/view/home_screen.dart';
import '../../../Upload/widget/AppBar_Upload.dart';
import '../widget/DataTextField.dart';
import '../widget/DoneButton.dart';
import '../widget/SegmentSellButton.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellscreenState();
}

class _SellscreenState extends State<SellScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? imageUrl;

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddDataCubit, AddDataState>(
        listener: (context, state) {
          if (state is AddFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is AddSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Product added successfully")),
            );
          } else if (state is AddLoading) {
            const Center(child: CircularProgressIndicator());
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      BlocConsumer<UploadCubit, UploadState>(
                        listener: (context, state) {
                          if (state is UploadSuccess) {
                            imageUrl = state.imageUrl;
                          }
                        },
                        builder: (context, state) {
                          return Container(
                            width: double.infinity,
                            height: 377.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: imageUrl != null
                                  ? DecorationImage(
                                      image: NetworkImage(imageUrl!),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                              color: Colors.grey[300],
                            ),
                          );
                        },
                      ),
                      const AppBarUpload(isvisible: true),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const Segmentsellbutton(),
                  const SizedBox(height: 50),
                  BlocConsumer<Testproduct, productState>(
                    listener: (context, state) {
                      if (state == productState.Sell) {}
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          Datatextfield(
                            hinttext: "Product Name",
                            controller: productNameController,
                            currentState: state,
                          ),
                          Datatextfield(
                            hinttext: "Description",
                            controller: descriptionController,
                            currentState: state,
                          ),
                          Datatextfield(
                            hinttext: "Price",
                            controller: priceController,
                            isPriceField: true,
                            currentState: state,
                            isVisible: state == productState.Sell,
                          ),
                          Datatextfield(
                            hinttext: "Your Address",
                            controller: addressController,
                            currentState: state,
                          ),
                          SizedBox(height: 60.h),
                          DoneButton(
                            Continue: () async {
                              if (_formKey.currentState!.validate()) {
                                if (mounted) {
                                  context.read<AddDataCubit>().addProduct(
                                    productName: productNameController.text,
                                    description: descriptionController.text,
                                    price: priceController.text,
                                    address: addressController.text,
                                    imageUrl: imageUrl!,
                                  );
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const HomeScreen(),
                                    ),
                                  );
                                }
                              }
                            },
                            text: "Confirm",
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
