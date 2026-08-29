"""Show the exact reward quantity in the milestone detail popup."""

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / "home/web/client/js/app.3fe29340.js"
OLD = 'Số lượng x "+t._s(t.$utils.getMoney(t.item.amount))'
NEW = 'Số lượng x "+t._s(t.$utils.getMoney(t.item.amount,!1))'
ROUTE_OLD = 'r.u=function(t){return"js/route.f27c633a.js?v=20260810-8"}'
ROUTE_NEW = 'r.u=function(t){return"js/route.f27c633a.js?v=20260811-10"}'
ITEM_BODY_OLD = 'e("img",{attrs:{src:t.imgItem(t.item.icon),width:"70%",height:"auto",alt:t.item.name}})])'
ITEM_BODY_NEW = 'e("img",{attrs:{src:t.imgItem(t.item.icon),width:"70%",height:"auto",alt:t.item.name}}),t.item.description?e("UText",{staticClass:"UiItem__Description mt-2",attrs:{size:"0.78rem"}},[t._v(t._s(t.item.description))]):t._e()])'
ITEM_DIALOG_OLD = 'e("UDialog",{attrs:{max:"180px"}'
ITEM_DIALOG_NEW = 'e("UDialog",{attrs:{max:"320px"}'
ITEM_ROOT_OLD = 'return e("div",{staticClass:"UiItem",style:{"--ui-item-size":t.size}}'
ITEM_ROOT_NEW = 'return e("div",{class:["UiItem",t.qualityClass,{"UiItem--featured":t.isFeatured}],style:{"--ui-item-size":t.size}}'
ITEM_POPUP_OLD = 'e("UBox",{staticClass:"View",attrs:{title:t.item.name,width:"100%"}'
ITEM_POPUP_NEW = 'e("UBox",{class:["View","UiItemPopup",t.qualityClass],attrs:{title:t.item.name,width:"100%"}'
ITEM_DESCRIPTION_OLD = 't.item.description?e("UText",{staticClass:"UiItem__Description mt-2",attrs:{size:"0.78rem"}},[t._v(t._s(t.item.description))]):t._e()'
ITEM_DESCRIPTION_NEW = 't.item.type_description?e("UChip",{staticClass:"mt-2",attrs:{border:"",color:"dark"}},[t._v(t._s(t.item.type_description))]):t._e(),t.cleanDescription?e("UText",{staticClass:"UiItem__Description mt-2",attrs:{size:"0.78rem"}},[t._v(t._s(t.cleanDescription))]):t._e()'
ITEM_COMPONENT_OLD = 'props:{size:{type:String,default:null},item:{type:Object,default:null}},data:()=>({dialog:!1}),methods:{imgItem(t)'
ITEM_COMPONENT_NEW = 'props:{size:{type:String,default:null},item:{type:Object,default:null}},data:()=>({dialog:!1}),computed:{qualityClass(){let t=Math.max(0,Math.min(5,Number(this.item&&this.item.quality||0)));return"UiItem--quality-"+t},isFeatured(){let t=this.item||{};return 1==Number(t.featured)||Number(t.quality)>=5||/Rương|Hộp|Gói|Điển Tàng|Thần Trang|Thánh Vật|Trứng/i.test(String(t.name||""))},cleanDescription(){return String(this.item&&this.item.description||"").replace(/<br\\s*\\/?>/gi,"\\n").replace(/<[^>]+>/g,"").replace(/\\n\\s*/g,"\\n").trim()}},methods:{imgItem(t)'
ITEM_POPUP_CLICK_OLD = 'attrs:{title:t.item.name,width:"100%"},on:{click:function(e){t.dialog=!1}},scopedSlots:'
ITEM_POPUP_CLICK_NEW = 'attrs:{title:t.item.name,width:"100%"},scopedSlots:'
ITEM_FOOTER_OLD = 'e("UChip",{attrs:{border:"",color:"dark"}},[t._v("Số lượng x "+t._s(t.$utils.getMoney(t.item.amount,!1)))])],1)]},proxy:!0'
ITEM_FOOTER_NEW = 'e("UChip",{attrs:{border:"",color:"dark"}},[t._v("Số lượng x "+t._s(t.$utils.getMoney(t.item.amount,!1)))]) ,e("UButton",{staticClass:"ml-2",attrs:{color:"gray"},on:{click:function(e){t.dialog=!1}}},[t._v("Đóng")])],1)]},proxy:!0'


def main() -> None:
    source = TARGET.read_text(encoding="utf-8")
    replacements = [
        (OLD, NEW, "full reward quantity"),
        (ROUTE_OLD, ROUTE_NEW, "route cache version"),
        (ITEM_BODY_OLD, ITEM_BODY_NEW, "item description"),
        (ITEM_DIALOG_OLD, ITEM_DIALOG_NEW, "item dialog width"),
        (ITEM_ROOT_OLD, ITEM_ROOT_NEW, "item rarity root"),
        (ITEM_POPUP_OLD, ITEM_POPUP_NEW, "item rarity popup"),
        (ITEM_DESCRIPTION_OLD, ITEM_DESCRIPTION_NEW, "clean item description"),
        (ITEM_COMPONENT_OLD, ITEM_COMPONENT_NEW, "item rarity metadata"),
        (ITEM_POPUP_CLICK_OLD, ITEM_POPUP_CLICK_NEW, "popup click close"),
        (ITEM_FOOTER_OLD, ITEM_FOOTER_NEW, "popup close button"),
    ]
    changed = []
    for old, new, label in replacements:
        if source.count(new) == 1 and source.count(old) == 0:
            continue
        if label == "item description" and "t.cleanDescription?" in source:
            continue
        if source.count(old) != 1:
            raise SystemExit(f"Expected exactly one {label} target, found {source.count(old)}")
        source = source.replace(old, new, 1)
        changed.append(label)
    TARGET.write_text(source, encoding="utf-8")
    print("Patched: " + (", ".join(changed) if changed else "already current"))


if __name__ == "__main__":
    main()
