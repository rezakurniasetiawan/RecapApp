import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:recipe/constant.dart';
import 'package:recipe/controller/master_controller.dart';
import 'package:recipe/data/models/stuff_entities.dart';

class EditRecipePage extends StatelessWidget {
  EditRecipePage({super.key});

  final MasterController _c = Get.put(MasterController());

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
                child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  onPressed: () => _c.onCancel(),
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
                              "Hapus",
                              style: CustomTextTheme.heading4.copyWith(color: Colors.red),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(15),
                  children: [
                    (_c.recipe.image != null)
                        ? SizedBox(
                            width: double.infinity,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Image.memory(
                                    base64Decode(_c.recipe.image!),
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
                                  child: const Text('Hapus'),
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
                                    Text("Tambah Foto", style: CustomTextTheme.heading4.copyWith(color: textColor)),
                                    const SizedBox(height: 10),
                                    Text("(Max 2Mb)", style: CustomTextTheme.heading6.copyWith(color: mutedColor)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(height: 15),
                    Text("Nama Resep", style: CustomTextTheme.heading4),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: _c.recipe.name,
                      onChanged: (value) => _c.onChange("name", value),
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: CustomTextTheme.body1,
                        fillColor: cardColor,
                        hintText: "Masukkan nama",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Durasi memasak", style: CustomTextTheme.heading4),
                        const SizedBox(height: 10),
                        TextFormField(
                          initialValue: _c.recipe.duration.toString(),
                          onChanged: (value) => _c.onChange("duration", value),
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: CustomTextTheme.body1,
                            fillColor: cardColor,
                            hintText: "Masukkan durasi memasak (menit)",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Benua", style: CustomTextTheme.heading4),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<String>(
                          value: _c.recipe.continental,
                          decoration: InputDecoration(
                            filled: true,
                            hintStyle: CustomTextTheme.body1,
                            fillColor: cardColor,
                            hintText: "Masukkan benua",
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onChanged: (value) => _c.onChange("continental", value ?? "-"),
                          items: [
                            ..._c.countryList.map((e) => DropdownMenuItem(value: e['name'] ?? '', child: Text(e['name'] ?? ''))),
                          ],
                        ),
                      ],
                    ),
                    if (_c.recipe.continental != null && _c.loadingCountry == false) ...[
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Negara", style: CustomTextTheme.heading4),
                          const SizedBox(height: 10),
                          DropdownButtonFormField<String>(
                            value: _c.recipe.countries,
                            decoration: InputDecoration(
                              filled: true,
                              hintStyle: CustomTextTheme.body1,
                              fillColor: cardColor,
                              hintText: "Masukkan negara",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            onChanged: (value) => _c.onChange("countries", value ?? "-"),
                            items: [
                              ..._c.listCountry.map((e) => DropdownMenuItem(value: e['code'] ?? '', child: Text(e['country'] ?? ''))),
                            ],
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 15),
                    Text("Bahan bahan", style: CustomTextTheme.heading4),
                    if (_c.listStuffOnEntities.isNotEmpty) const SizedBox(height: 10),
                    if (_c.listStuffOnEntities.isNotEmpty)
                      Container(
                        color: cardColor,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ..._c.listStuffOnEntities
                                .asMap()
                                .map((index, e) {
                                  StuffEntities? entities = _c.listStuff.where((el) => el.id == e.idStuff).firstOrNull;
                                  return MapEntry(
                                    index,
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "${index + 1}. ${entities?.name ?? '-'} ${e.qty} ${entities?.unit ?? '-'}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => _c.deleteStuffOnRecipeEdit(e.id!, index),
                                            child: Text(
                                              "Hapus",
                                              style: CustomTextTheme.heading5.copyWith(color: Colors.red),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                                .values
                                .toList()
                          ],
                        ),
                      ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => Dialog.fullscreen(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(height: 15),
                                Expanded(
                                  child: ListView(
                                    children: [
                                      ..._c.listStuff.map((e) {
                                        return ListTile(
                                          onTap: () {
                                            Get.back();
                                            showDialog<String>(
                                              context: context,
                                              builder: (BuildContext context) => Dialog.fullscreen(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text("Jumlah (${e.unit})"),
                                                    Padding(
                                                      padding: const EdgeInsets.all(15),
                                                      child: TextField(
                                                        controller: _c.stuffQtyController,
                                                        textAlign: TextAlign.center,
                                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                                                        onPressed: () => _c.addStuffOnRecipeEdit(e),
                                                        child: const Text('Simpan'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          title: Text(e.name ?? '-'),
                                          subtitle: Text(e.description ?? '-'),
                                        );
                                      })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      child: const Text("Tambah bahan"),
                    ),
                    const SizedBox(height: 15),
                    Text("Cara Memasak", style: CustomTextTheme.heading4),
                    const SizedBox(height: 10),
                    TextFormField(
                      initialValue: _c.recipe.instruction,
                      onChanged: (value) => _c.onChange("instruction", value),
                      maxLines: 10,
                      decoration: InputDecoration(
                        filled: true,
                        hintStyle: CustomTextTheme.body1,
                        fillColor: cardColor,
                        hintText: "Masukkan cara memasak",
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
                  child: const Text('Simpan'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
