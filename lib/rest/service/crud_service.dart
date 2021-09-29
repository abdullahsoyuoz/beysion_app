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


import '../persistent.dart';

abstract class CrudService<T extends Persistent>{

  final apiURL = "https://beysion.getusoft.com/api";
  final mainServerURL = "https://beysion.getusoft.com";

}