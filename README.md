# processApi

A utility mixin class for handling API requests with loading and error handling in Flutter.

## Overview

The BaseService mixin class provides a convenient way to handle API requests in a Flutter application. It includes a processApi function that simplifies the process of making API requests by providing a standardized way to handle loading and error states.

## Features

- Handles loading state with a callback function
- Handles error states with a callback function
- Provides a flexible way to make API requests with error handling

## Usage

To use the BaseService mixin class, simply mix it into your service class and call the processApi function:

```
class MyService with BaseService {
  Future<void> fetchData() async {
    await processApi(
      () async {
        // Make API request here
        final response = await http.get(Uri.parse('https://example.com/api/data'));
        return response.json();
      },
      onLoading: (loading) {
        // Handle loading state here
        print('Loading: $loading');
      },
      onError: (error, stackTrace) {
        // Handle error state here
        print('Error: $error, StackTrace: $stackTrace');
      },
    );
  }
}
```

## processApi function
- Future<T?> processApi<T>(Future<T?> Function() request, {LoadingCallback? onLoading, ErrorCallback? onError})
  - <b>request</b>: A function that returns a Future representing the API request.
  - <b>onLoading</b>: A callback function that is called when the API request is in progress. The function takes a bool parameter indicating whether the request is loading.
  - <b>onError</b>: A callback function that is called when an error occurs during the API request. The function takes an Object? parameter representing the error and a StackTrace parameter representing the stack trace.

## Contributing

Contributions are welcome! If you'd like to contribute to this project, please open a pull request with your changes.