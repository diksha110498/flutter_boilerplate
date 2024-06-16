import 'export.dart';

class CustDropDown<T> extends StatefulWidget {
  final List<CustDropdownMenuItem> items;
  final Function onChanged;
  final String hintText;
  final int defaultSelectedIndex;
  final bool enabled;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;
  final String? prefixImage;
  final String? suffixIImage;

  const CustDropDown(
      {required this.items,
        required this.onChanged,
        required this.textEditingController,
        required this.focusNode,
        this.prefixImage,
        this.suffixIImage,
        this.hintText = "",
        this.defaultSelectedIndex = -1,
        Key? key,
        this.enabled = true})
      : super(key: key);

  @override
  _CustDropDownState createState() => _CustDropDownState();
}

class _CustDropDownState extends State<CustDropDown>
    with WidgetsBindingObserver {
  bool _isOpen = false, _isAnyItemSelected = false, _isReverse = false;
  late OverlayEntry _overlayEntry;
  late RenderBox? _renderBox;
  Widget? _itemSelected;
  late Offset dropDownOffset;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          dropDownOffset = getOffset();
        });
      }
      if (widget.defaultSelectedIndex > -1) {
        if (widget.defaultSelectedIndex < widget.items.length) {
          if (mounted) {
            setState(() {
              _isAnyItemSelected = true;
              _itemSelected = widget.items[widget.defaultSelectedIndex];
              widget.onChanged(widget.items[widget.defaultSelectedIndex].value);
            });
          }
        }
      }
    });
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void _addOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = true;
      });
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }

  void _removeOverlay() {
    if (mounted) {
      setState(() {
        _isOpen = false;
      });
      _overlayEntry.remove();
    }
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    _renderBox = context.findRenderObject() as RenderBox?;

    var size = _renderBox!.size;

    dropDownOffset = getOffset();

    return OverlayEntry(
        maintainState: false,
        builder: (context) => Align(
          alignment: Alignment.center,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: dropDownOffset,
            child: SizedBox(
              width: size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  padding: EdgeInsets.all(AppSizes.smallPadding),
                  constraints:
                  BoxConstraints(maxWidth: size.width, maxHeight: 200),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: AppColors.textFieldBorderColor,
                            blurRadius: 10.0,
                            spreadRadius: 3.0)
                      ],
                      borderRadius: BorderRadius.circular(12)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.defaultRoundedRadius),
                    ),
                    child: Material(
                      elevation: 0,
                      color: Colors.white,
                      shadowColor: Colors.grey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: widget.items
                            .map((item) => GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: item.child,
                          ),
                          onTap: () {
                            if (mounted) {
                              setState(() {
                                _isAnyItemSelected = true;
                                _itemSelected = item.child;
                                _removeOverlay();
                                if (widget.onChanged != null)
                                  widget.onChanged(item.value);
                              });
                            }
                          },
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Offset getOffset() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    double y = renderBox!.localToGlobal(Offset.zero).dy;
    double spaceAvailable = _getAvailableSpace(y + renderBox.size.height);
    if (spaceAvailable > 100) {
      _isReverse = false;
      return Offset(0, renderBox.size.height);
    } else {
      _isReverse = true;
      return Offset(0, renderBox.size.height - (100 + renderBox.size.height));
    }
  }

  double _getAvailableSpace(double offsetY) {
    double safePaddingTop = MediaQuery.of(context).padding.top;
    double safePaddingBottom = MediaQuery.of(context).padding.bottom;

    double screenHeight =
        MediaQuery.of(context).size.height - safePaddingBottom - safePaddingTop;

    return screenHeight - offsetY;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: CustomTextField(
          widget.textEditingController, widget.focusNode, widget.hintText,
          readOnly: true, onTap: () {
        _isOpen ? _removeOverlay() : _addOverlay();
      },
          prefixIcon: (widget.prefixImage == null)
              ? const SizedBox.shrink()
              : Padding(
            padding: EdgeInsets.only(right: AppSizes.microPadding),
            child: Image.asset(widget.prefixImage!,
                height: AppSizes.mediumIconSize,
                width: AppSizes.mediumIconWidthSize),
          ),
          suffixIcon: Image.asset(
              widget.suffixIImage ?? AppImages.dropDownIcon ?? "",
              height: AppSizes.mediumIconSize,
              width: AppSizes.mediumIconWidthSize)),
    );
  }
}

class CustDropdownMenuItem<T> extends StatelessWidget {
  final T value;
  final Widget child;

  const CustDropdownMenuItem({required this.value, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
