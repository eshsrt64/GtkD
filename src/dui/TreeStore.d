/*
 * This file is part of dui.
 * 
 * dui is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 * 
 * dui is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with dui; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

module dui.TreeStore;

private import def.Types;
private import def.Constants;
private import ddi.Value;
private import dui.Utils;
private import dui.ObjectG;
private import dui.TreeModel;
private import dui.TreePath;
private import ddi.Value;

alias GObject GtkTreeStore;

private import dui.TreeIter;

private:

extern(C)
{
	GType gtk_tree_store_get_type();
	GtkTreeStore * gtk_tree_store_new(gint n_columns,...);
	GtkTreeStore * gtk_tree_store_newv(gint n_columns, GType * types);
	void gtk_tree_store_set_column_types(GtkTreeStore * tree_store, gint n_columns, GType * types);
	
	/* NOTE: use gtk_tree_model_get to get values from a GtkTreeStore */
	
	void gtk_tree_store_set_value(GtkTreeStore * tree_store, GtkTreeIter * iter, gint column, GValue * value);
	void gtk_tree_store_set(GtkTreeStore * tree_store, GtkTreeIter * iter,...);
	void gtk_tree_store_set_valist(GtkTreeStore * tree_store, GtkTreeIter * iter, vaList var_args);
	gboolean gtk_tree_store_remove(GtkTreeStore * tree_store, GtkTreeIter * iter);
	void gtk_tree_store_insert(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * parent, gint position);
	void gtk_tree_store_insert_before(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * parent, GtkTreeIter * sibling);
	void gtk_tree_store_insert_after(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * parent, GtkTreeIter * sibling);
	void gtk_tree_store_prepend(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * parent);
	void gtk_tree_store_append(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * parent);
	gboolean gtk_tree_store_is_ancestor(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * descendant);
	gint gtk_tree_store_iter_depth(GtkTreeStore * tree_store, GtkTreeIter * iter);
	void gtk_tree_store_clear(GtkTreeStore * tree_store);
	gboolean gtk_tree_store_iter_is_valid(GtkTreeStore * tree_store, GtkTreeIter * iter);
	void gtk_tree_store_reorder(GtkTreeStore * tree_store, GtkTreeIter * parent, gint * new_order);
	void gtk_tree_store_swap(GtkTreeStore * tree_store, GtkTreeIter * a, GtkTreeIter * b);
	void gtk_tree_store_move_before(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * position);
	void gtk_tree_store_move_after(GtkTreeStore * tree_store, GtkTreeIter * iter, GtkTreeIter * position);
}
/**
 * A tree model that represents a tree structure.
 */
public:
class TreeStore : TreeModel
{

	private import dool.String;
	
	debug(status)
	{
		int complete(){return 10;}
		char[] gtkName(){return ST_SAME_NAME;}
		char[] description(){return "A tree model that represents a tree structure";}
		char[] author(){return "Antonio";}
	}

	/**
	 * Gets this class type
	 * @return this class type
	 */
	GType getType()
	{
		return gtk_tree_store_get_type();
	}

	protected:

	this(GObject * gObject)
	{
		super(gObject);
	}

	public:

	/**
	 * Creates a new TreeStore with the defined types
	 * @param types the types of the column to create
	 */
	this(GType [] types)
	{
		GType *t = types;
		//printf("Creating a TreeStore with %d columns\n",types.length);
		//for ( int i=0 ; i< types.length ; i++ )
		//{
		//	printf("\tColumn type %d = %d\n",i,types[i]);
		//}
		this(gtk_tree_store_newv(types.length, t));
	}

	/**
	 * Gets the GtkModel - internal use only
	 */
	GtkTreeModel* model()
	{
		return cast(GtkTreeModel*)super.obj();
	}

	/**
	 * Creates a new top level Tree iterator.
	 * effectevly this is the way to start to add entries to the model
	 * @return a new top level tree iteractor
	 */
	TreeIter createIter()
	{
		TreeIter iter = new TreeIter();
		gtk_tree_store_append (obj(), iter.getIter(),null);
		iter.setModel(this);
		return iter;
	}
	
	/+
	/** \todo */
	GtkTreeStore * gtk_tree_store_new(gint n_columns,...);

	/** \todo */
	void gtk_tree_store_set_column_types(GtkTreeStore * tree_store, gint n_columns, GType * types);
	
	/* NOTE: use gtk_tree_model_get to get values from a GtkTreeStore */
	+/
	
	void setValue(TreeIter iter, int column, Value value)
	{
		printf("TreeStore.setValue column = %d\n", column);
		value.dump();
		
		gtk_tree_store_set_value(obj(), iter.getIter(), column, value.getV());
	}
	
	/**
	 * Sets one value into one cells.
	 * @param iter the tree iteractor, effectivly the row
	 * @param column to column number to set
	 * @param value the value
	 */
	void setValue(TreeIter iter, int column, char[] value)
	{
		Value v = new Value(value);
		gtk_tree_store_set_value(obj(), iter.getIter(), column, v.getV());
	}

	/**
	 * Sets an iteractor values.
	 * This is the way to add a new row to the tree,
	 * the iteractor is either a top level iteractor created from createIter()
	 * or a nested iteractor created from append()
	 * @param iter the iteractor to set
	 * @param columns the numbers of the columns to set
	 * @param values the values to set into the cells
	 * @see createIter()
	 * @see append()
	 */
	void set(TreeIter iter, int [] columns, void*[] values)
	{
		for ( int i=0 ; i<columns.length && i<values.length; i++ )
		{
			gtk_tree_store_set(obj(), iter.getIter(), columns[i], cast(char*)values[i],-1);
			// -- no good -- setValue(iter,columns[i],values[i]);
		}
	}

	/**
	 * Sets an iteractor values.
	 * This is the way to add a new row to the tree,
	 * the iteractor is either a top level iteractor created from createIter()
	 * or a nested iteractor created from append()
	 * @param iter the iteractor to set
	 * @param columns the numbers of the columns to set
	 * @param values the values to set into the cells
	 * @see createIter()
	 * @see append()
	 */
	void set(TreeIter iter, int [] columns, String[] values)
	{
		for ( int i=0 ; i<columns.length && i<values.length; i++ )
		{
			gtk_tree_store_set(obj(), iter.getIter(), columns[i], values[i].toStringz(),-1);
			// -- no good -- setValue(iter,columns[i],values[i]);
		}
	}

	/**
	 * Sets an iteractor values from a tree node.
	 * This is the way to add a new row to the tree,
	 * the iteractor is either a top level iteractor created from createIter()
	 * or a nested iteractor created from append()
	 * @param iter the iteractor to set
	 * @param treeNode the tree node
	 * @see createIter()
	 * @see append()
	 */
	void set(TreeIter iter, TreeNode treeNode)
	{
		int[] cols;
		String[] vals;
		for ( int i=0 ; i<getNColumns() ; i++ )
		{
			//printf(">>>>>>>>>>>>> requesting value for %d\n",i);
			cols ~= i;
			void* value = treeNode.getNodeValue(i);
			if ( value === null )
			{
				value = cast(void*)((new String(String.EMPTY_Z)).toStringz());
			}
			vals ~= new String(value);
		}
		set(iter, cols, vals);				
	}

	/+
	/** \todo */
	void gtk_tree_store_set_valist(GtkTreeStore * tree_store, GtkTreeIter * iter, vaList var_args);
	+/
	
	/**
	 * Removes a row from the list
	 * @param iter the iteract that contains the row
	 * @return true if succesefull
	 */
	bit remove(TreeIter iter)
	{
		return gtk_tree_store_remove(obj(), iter.getIter()) == 0 ? false : true;
	}
	
	/**
	 * insert
	 * @param iter
	 * @param parent
	 * @param position
	 * @param 
	 */
	void insert(TreeIter iter, TreeIter parent, gint position)
	{
		gtk_tree_store_insert(obj(), iter.getIter(), parent.getIter(), position);
	}
	
	/**
	 * insertBefore
	 * @param iter
	 * @param parent
	 * @param sibling
	 */
	void insertBefore(TreeIter iter, TreeIter parent, TreeIter  sibling)
	{
		gtk_tree_store_insert_before(obj(), iter.getIter(),
				(parent===null) ? null : parent.getIter(), 
				(sibling===null) ? null : sibling.getIter());
	}
	
	/**
	 * insertAfter
	 * @param iter
	 * @param parent
	 * @param sibling
	 */
	void insertAfter(TreeIter iter, TreeIter parent, TreeIter  sibling)
	{
		gtk_tree_store_insert_after(obj(), iter.getIter(), 
				(parent===null) ? null : parent.getIter(), 
				(sibling===null) ? null : sibling.getIter());
	}
	
	/**
	 * prepend
	 * @param iter
	 * @param parent
	 */
	void prepend(TreeIter iter, TreeIter parent)
	{
		gtk_tree_store_prepend(obj(), iter.getIter(), parent.getIter());
	}
	
	/**
	 * Creates a new tree iteractor (effectivly a new row) nested on the passed parent iteractor
	 * @param parentIter
	 * @return a new tree iteractor
	 */
	TreeIter append(TreeIter parentIter)
	{
		TreeIter iter = new TreeIter();
		gtk_tree_store_append (obj(), iter.getIter(),parentIter.getIter());
		return iter;
	}

	/**
	 * isAncestor
	 * @param iter
	 * @param descendant
	 */
	bit isAncestor(TreeIter iter, TreeIter descendant)
	{
		return gtk_tree_store_is_ancestor(obj(), iter.getIter(), descendant.getIter()) == 0 ? false : true;
	}
	/**
	 * iterDepth
	 * @param iter
	 */
	gint iterDepth(TreeIter iter)
	{
		return gtk_tree_store_iter_depth(obj(), iter.getIter());
	}
	
	/**
	 * removes all entries from the tree
	 */
	void clear()
	{
		gtk_tree_store_clear(obj());
	}
	
	/**
	 * iterIsValid
	 * @param iter
	 */
	bit iterIsValid(TreeIter iter)
	{
		return gtk_tree_store_iter_is_valid(obj(), iter.getIter()) == 0 ? false : true;
	}

	/**
	 * reorder
	 * @param parent
	 * @param newOrder
	 */
	void reorder(TreeIter parent, gint[] newOrder)
	{
		gtk_tree_store_reorder(obj(), parent.getIter(), cast(int*)newOrder);
	}

	/**
	 * swap
	 * @param a
	 * @param b
	 */
	void swap(TreeIter a, TreeIter b)
	{
		gtk_tree_store_swap(obj(), a.getIter(), b.getIter());
	}

	/**
	 * moveAfter
	 * @param iter
	 * @param position
	 */
	void moveAfter(TreeIter iter, TreeIter position)
	{
		gtk_tree_store_move_after(obj(), iter.getIter(), position.getIter());
	}

	/**
	 * modeBefore
	 * @param iter
	 * @param position
	 */
	void modeBefore(TreeIter iter, TreeIter position)
	{
		gtk_tree_store_move_before(obj(), iter.getIter(), position.getIter());
	}



}