import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/controller/master_controller.dart';

class EditStuffPage extends StatelessWidget {
  EditStuffPage({super.key});

  final MasterController _c = Get.put(MasterController());

  final List<StuffUnit> _stuffUnit = [
    StuffUnit(name: 'Gram', value: 'gr'),
    StuffUnit(name: 'Mililiter', value: 'ml'),
    StuffUnit(name: 'Pcs', value: 'pcs'),
    StuffUnit(name: 'Spoon', value: 'sdm'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Obx(
        () => SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _c.delete(),
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.red),
                          const SizedBox(width: 10),
                          Text(
                            "Delete",
                            style: CustomTextTheme.heading4.copyWith(color: Colors.red),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    (_c.stuff.image != null)
                        ? SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.memory(
                                    base64Decode(_c.stuff.image!),
                                    width: double.infinity,
                                    height: 150,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                                      if (states.contains(MaterialState.disabled)) {
                                        return Colors.redAccent.withOpacity(0.3);
                                      } else {
                                        return Colors.redAccent;
                                      }
                                    }),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                  ),
                                  onPressed: () => _c.deleteImage(),
                                  child: const Text('Delete'),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () => _c.pickStuffImage(),
                            child: DottedBorder(
                              dashPattern: const [4],
                              borderType: BorderType.RRect,
                              color: mutedColor,
                              radius: const Radius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const Icon(FeatherIcons.image, size: 50, color: mutedColor),
                                    const SizedBox(height: 10),
                                    Text("Add Cover Photo", style: CustomTextTheme.heading4.copyWith(color: textColor)),
                                    const SizedBox(height: 10),
                                    Text("(up to 2Mb)", style: CustomTextTheme.heading6.copyWith(color: mutedColor)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 15),
                    Text("Stuff Name", style: CustomTextTheme.heading4),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: _c.stuff.name,
                      onChanged: (value) => _c.onChange("name", value),
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: CustomTextTheme.body1,
                        fillColor: cardColor,
                        hintText: "Enter name",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Price", style: CustomTextTheme.heading4),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: _c.stuff.price.toString(),
                                onChanged: (value) => _c.onChange("price", value),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                  filled: true,
                                  hintStyle: CustomTextTheme.body1,
                                  fillColor: cardColor,
                                  hintText: "Enter price",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Stock", style: CustomTextTheme.heading4),
                              const SizedBox(height: 10),
                              TextFormField(
                                initialValue: _c.stuff.stock.toString(),
                                onChanged: (value) => _c.onChange("stock", value),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                decoration: InputDecoration(
                                  filled: true,
                                  hintStyle: CustomTextTheme.body1,
                                  fillColor: cardColor,
                                  hintText: "Enter stock",
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text("Unit", style: CustomTextTheme.heading4),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<StuffUnit>(
                      value: _stuffUnit.where((element) => element.name == _c.stuff.unit).firstOrNull,
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: CustomTextTheme.body1,
                        fillColor: cardColor,
                        hintText: "Enter unit",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onChanged: (value) => _c.onChange("unit", value?.name ?? "-"),
                      items: [
                        ..._stuffUnit.map(
                          (e) => DropdownMenuItem(value: e, child: Text(e.name ?? '')),
                        )
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text("Description", style: CustomTextTheme.heading4),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: _c.stuff.description,
                      onChanged: (value) => _c.onChange("description", value),
                      maxLines: 10,
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: CustomTextTheme.body1,
                        fillColor: cardColor,
                        hintText: "Enter description",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16, horizontal: 30)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.disabled)) {
                        return primaryColor.withOpacity(0.3);
                      } else {
                        return primaryColor;
                      }
                    }),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: _c.isBtnEnabled ? () => _c.onEdit() : null,
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
