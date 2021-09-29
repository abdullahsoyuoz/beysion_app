/*
 *  DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
 *
 *  Copyright (C) 2021 Rich Design - All Rights Reserved
 *  Unauthorized copying of this file, via any medium is strictly prohibited
 *  Proprietary and confidential.
 *
 *  Written by Yakup Zengin <yakup@designsrich.com>, March 2021
 *
 */

import 'package:flutter/material.dart';

double getSize(BuildContext context, bool isWidth, double percentage){
  if(isWidth)
    return MediaQuery.of(context).size.width * percentage;
  return MediaQuery.of(context).size.height * percentage;
}