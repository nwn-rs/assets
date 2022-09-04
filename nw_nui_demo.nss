#include "nw_inc_nui"
#include "nw_inc_nui_insp"

void MakePortraitFlipper(object pc)
{
  json col;
  json row;

  col = JsonArray();

  row = JsonArray();
    row = JsonArrayInsert(row, NuiSpacer());
    row = JsonArrayInsert(row, JsonObjectSet(NuiLabel(NuiBind("po_resref"), JsonNull(), JsonNull()), "text_color",
            NuiColor(255, 0, 0)));
    row = JsonArrayInsert(row, NuiSpacer());
  col = JsonArrayInsert(col, NuiHeight(NuiRow(row), 20.0));

  row = JsonArray();
    row = JsonArrayInsert(row, NuiSpacer());
    row = JsonArrayInsert(row, NuiLabel(NuiBind("po_id"), JsonNull(), JsonNull()));
    row = JsonArrayInsert(row, NuiSpacer());
  col = JsonArrayInsert(col, NuiHeight(NuiRow(row), 20.0));

  row = JsonArray();
    row = JsonArrayInsert(row, NuiSpacer());
    json img = NuiImage(NuiBind("po_resref"),
                        JsonInt(NUI_ASPECT_EXACT),
                        JsonInt(NUI_HALIGN_CENTER),
                        JsonInt(NUI_VALIGN_TOP));
    img = NuiGroup(img);
    img = NuiWidth(img, 256.0);
    img = NuiHeight(img, 400.0);
    row = JsonArrayInsert(row, img);
    row = JsonArrayInsert(row, NuiSpacer());
  col = JsonArrayInsert(col, NuiRow(row));

  row = JsonArray();
  {
    row = JsonArrayInsert(row, NuiSpacer());
    // TODO: Width(100%)
    row = JsonArrayInsert(row, NuiId(NuiCombo(NuiBind("po_categories"), NuiBind("po_category")), "category"));
    row = JsonArrayInsert(row, NuiSpacer());
  }
  col = JsonArrayInsert(col, NuiRow(row));

  row = JsonArray();
    json btnprev = NuiEnabled(NuiId(NuiButton(JsonString("<")), "btnprev"), NuiBind("btnpreve"));
    json btnok   = NuiEnabled(NuiId(NuiButton(JsonString("Set")), "btnok"), NuiBind("btnoke"));
    json btnnext = NuiEnabled(NuiId(NuiButton(JsonString(">")), "btnnext"), NuiBind("btnnexte"));
    row = JsonArrayInsert(row, NuiWidth(btnprev, 80.0));
    row = JsonArrayInsert(row, NuiSpacer());
    row = JsonArrayInsert(row, NuiWidth(btnok, 80.0));
    row = JsonArrayInsert(row, NuiSpacer());
    row = JsonArrayInsert(row, NuiWidth(btnnext, 80.0));
  col = JsonArrayInsert(col, NuiRow(row));

  json root = NuiCol(col);
	json nui = NuiWindow(
    root,
    NuiBind("po_resref"),
    NuiBind("geometry"),
    NuiBind("resizable"),
    NuiBind("collapsed"),
    NuiBind("closable"),
    NuiBind("transparent"),
    NuiBind("border"));

	int token = NuiCreate(pc, nui, "poviewer");

  int id = 164;
  string ref = "po_" + Get2DAString("portraits", "BaseResRef", id) + "h";
  NuiSetBind(pc, token, "po_id", JsonInt(id));
  NuiSetBind(pc, token, "po_resref", JsonString(ref));
  NuiSetBind(pc, token, "btnpreve", JsonBool(0));
  NuiSetBind(pc, token, "btnnexte", JsonBool(1));

  json combovalues = JsonArray();
  combovalues = JsonArrayInsert(combovalues, NuiComboEntry("Cats (164-167)", 0));
  combovalues = JsonArrayInsert(combovalues, NuiComboEntry("Dragons (191-200)", 1));
  NuiSetBind(pc, token, "po_categories", combovalues);
  NuiSetBind(pc, token, "po_category", JsonInt(0));

  NuiSetBind(pc, token, "collapsed", JsonBool(FALSE));
  NuiSetBind(pc, token, "resizable", JsonBool(FALSE));
  NuiSetBind(pc, token, "closable", JsonBool(TRUE));
  NuiSetBind(pc, token, "transparent", JsonBool(FALSE));
  NuiSetBind(pc, token, "border", JsonBool(TRUE));

  NuiSetBind(pc, token, "geometry", NuiRect(420.0, 10.0, 400.0, 600.0));

  NuiSetBindWatch(pc, token, "po_category", TRUE);
  NuiSetBindWatch(pc, token, "collapsed", TRUE);
  NuiSetBindWatch(pc, token, "geometry", TRUE);
}

void main()
{
  SetEventScript(GetModule(), EVENT_SCRIPT_MODULE_ON_NUI_EVENT, "nw_nui_demo_evt");
	object pc = GetFirstPC();
  MakeWindowInspector(pc);
  MakePortraitFlipper(pc);
}
