import 'package:crud_operation_dio/constants/routes_constants.dart';
import 'package:crud_operation_dio/models/user.dart';
import 'package:crud_operation_dio/providers/user_provider.dart';
import 'package:crud_operation_dio/widgets/user_row_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});

  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  late ScrollController _scrollController = ScrollController();
  List<Datum>? userData;
  late bool _isLoading;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider).getUserAsync();
    });
    _scrollController = ScrollController()
      ..addListener(() {
        ref.read(userProvider).loadNextPage();
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void onPressed(BuildContext context, Datum user) {
    ref.read(userProvider).getCurrentUser(user, true);
    Navigator.of(context).pushNamed(RoutesConstants.update);
  }

  @override
  Widget build(BuildContext context) {
    userData = ref.watch(userProvider).datum;
    _isLoading = ref.watch(userProvider).isLoading;

    Widget content = const Center(child: CircularProgressIndicator());

    content = !_isLoading && userData != null
        ? Padding(
            padding: const EdgeInsets.all(15),
            child: RefreshIndicator(
              onRefresh: () => ref.read(userProvider).refreshData(),
              child: ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemCount: userData?.length,
                itemBuilder: (ctx, index) => Slidable(
                  startActionPane: ActionPane(
                    motion: const BehindMotion(),
                    extentRatio: .24,
                    children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            bottomLeft: Radius.circular(15)),
                        onPressed: (context) =>
                            onPressed(context, userData![index]),
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Update',
                      )
                    ],
                  ),
                  endActionPane: ActionPane(
                    extentRatio: .24,
                    motion: const BehindMotion(),
                    children: [
                      SlidableAction(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15)),
                        onPressed: (ctx) {
                          ref
                              .read(userProvider)
                              .deleteUser(userData![index].id, context);
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      )
                    ],
                  ),
                  child: UserItem(data: userData![index]),
                ),
              ),
            ),
          )
        : Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              ref.read(userProvider).getCurrentUser(
                  Datum(
                    id: 0,
                    email: '',
                    firstName: '',
                    lastName: '',
                    avatar: '',
                  ),
                  false);
              Navigator.pushNamed(context, RoutesConstants.update);
            },
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: content,
    );
  }
}
