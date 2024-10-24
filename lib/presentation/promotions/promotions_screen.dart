import 'package:customer_hailing/core/app_export.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_text_form_field.dart';
import 'controllers/promotions_controller.dart';

class PromotionsScreen extends StatefulWidget {
  const PromotionsScreen({super.key});

  @override
  State<PromotionsScreen> createState() => _PromotionsScreenState();
}
class _PromotionsScreenState extends State<PromotionsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController promoController = TextEditingController();
  bool _isButtonEnabled = false;

  final PromoController controller = Get.put(PromoController());

  @override
  void initState() {
    super.initState();
    promoController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    promoController.dispose();
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = promoController.text.isNotEmpty;
    });
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      controller.activatePromo(promoController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Promotions',
          style: TextStyle(
            color: Color(0xFF767676),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 17,
            color: blackTextColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Promo code",
                style: TextStyle(
                  color: formTextLabelColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                controller: promoController,
                filled: true,
                fillColor: countryTextFieldColor,
                hintText: "Enter your promo code",
                hintStyle: const TextStyle(
                  color: blackTextColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
                autofocus: false,
                height: 96.h,
                contentPadding: EdgeInsets.symmetric(vertical: 15.v, horizontal: 10.h),
                borderDecoration: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.h),
                  borderSide: const BorderSide(color: Colors.transparent, width: 0),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.errorMessage.isNotEmpty) {
                  return Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                return const SizedBox.shrink();
              }),
              Obx(() => Visibility(
                visible: controller.isActivated.value && controller.activePromos.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your active promotions',
                      style: TextStyle(
                        color: Color(0xFF767676),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.activePromos.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.only(top: 9, left: 16, right: 38, bottom: 9),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: ListTile(
                            title: Text(controller.activePromos[index]),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )),
              const Spacer(),
              Padding(
                padding: EdgeInsets.zero,
                child: CustomElevatedButton(
                  text: 'Activate',
                  onPressed: _isButtonEnabled
                      ? () {
                    onSubmit();
                  }
                      : null,
                  buttonStyle: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled ? primaryColor : disabledButtonGrey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
