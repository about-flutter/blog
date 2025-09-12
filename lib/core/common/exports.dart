/// This file exports common entities, models, and utilities
/// to be imported as a single import in other files

// Common entities
export 'package:blog/core/common/entities/user.dart';

// Common widgets
export 'package:blog/core/common/widgets/loader.dart';
export 'package:blog/core/common/widgets/router_outlet.dart';

// Cubits
export 'package:blog/core/common/cubits/app_user/app_user_cubit.dart';
// app_user_state.dart is a part of app_user_cubit.dart so it's already exported

// Theme
export 'package:blog/core/theme/theme.dart';
export 'package:blog/core/theme/appPalette.dart';

// Utils
export 'package:blog/core/utils/calculate_reading_time.dart';
export 'package:blog/core/utils/pick_image.dart';
export 'package:blog/core/utils/show_snackbar.dart';

// Constants
export 'package:blog/core/constants/route_constants.dart';

// Navigation
export 'package:blog/core/navigation/navigation_service.dart';
