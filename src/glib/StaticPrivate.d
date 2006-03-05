/*
 * This file is part of duit.
 *
 * duit is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation; either version 2.1 of the License, or
 * (at your option) any later version.
 *
 * duit is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with duit; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
 
// generated automatically - do not change
// find conversion definition on APILookup.txt
// implement new conversion functionalities on the wrap.utils pakage

/*
 * Conversion parameters:
 * outPack = glib
 * outFile = StaticPrivate
 * strct   = GStaticPrivate
 * realStrct=
 * clss    = StaticPrivate
 * extend  = 
 * prefixes:
 * 	- g_static_private_
 * omit structs:
 * omit prefixes:
 * omit code:
 * imports:
 * 	- glib.Dataset
 * structWrap:
 * 	- GDataset* -> Dataset
 * local aliases:
 */

module glib.StaticPrivate;

private import glib.typedefs;

private import lib.glib;

private import glib.Dataset;
/**
 * Description
 * Threads act almost like processes, but unlike processes all threads of
 * one process share the same memory. This is good, as it provides easy
 * communication between the involved threads via this shared memory, and
 * it is bad, because strange things (so called Heisenbugs) might happen,
 * when the program is not carefully designed. Especially bad is, that due
 * to the concurrent nature of threads no assumptions on the order of
 * execution of different threads can be done unless explicitly forced by
 * the programmer through synchronization primitives.
 * The aim of the thread related functions in GLib is to provide a
 * portable means for writing multi-threaded software. There are
 * primitives for mutexes to protect the access to portions of memory
 * (GMutex, GStaticMutex, G_LOCK_DEFINE, GStaticRecMutex and
 * GStaticRWLock), there are primitives for condition variables to allow
 * synchronization of threads (GCond) and finally there are primitives
 * for thread-private data, that every thread has a private instance of
 * (GPrivate, GStaticPrivate). Last but definitely not least there are
 * primitives to portably create and manage threads (GThread).
 * You must call g_thread_init() before executing any other GLib functions
 * in a threaded GLib program. After that, GLib is completely thread safe
 * (all global data is automatically locked). But individual data structure
 * instances are not automatically locked for performance reasons. So e.g.
 * you must coordinate accesses to the same GHashTable from multiple threads.
 * The two notable exceptions from this rule are GMainLoop and GAsyncQueue,
 * which are threadsafe and needs no further
 * application-level locking to be accessed from multiple threads.
 */
public class StaticPrivate
{
	
	/** the main Gtk struct */
	protected GStaticPrivate* gStaticPrivate;
	
	
	public GStaticPrivate* getStaticPrivateStruct()
	{
		return gStaticPrivate;
	}
	
	
	/** the main Gtk struct as a void* */
	protected void* getStruct()
	{
		return cast(void*)gStaticPrivate;
	}
	
	/**
	 * Sets our main struct and passes it to the parent class
	 */
	public this (GStaticPrivate* gStaticPrivate)
	{
		this.gStaticPrivate = gStaticPrivate;
	}
	
	/**
	 */
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * Initializes private_key. Alternatively you can initialize it with
	 * G_STATIC_PRIVATE_INIT.
	 * private_key:
	 * a GStaticPrivate to be initialized.
	 */
	public void init()
	{
		// void g_static_private_init (GStaticPrivate *private_key);
		g_static_private_init(gStaticPrivate);
	}
	
	/**
	 * Works like g_private_get() only for a GStaticPrivate.
	 * This function also works, if g_thread_init() has not yet been called.
	 * private_key:
	 * a GStaticPrivate.
	 * Returns:
	 * the corresponding pointer.
	 */
	public void* get()
	{
		// gpointer g_static_private_get (GStaticPrivate *private_key);
		return g_static_private_get(gStaticPrivate);
	}
	
	/**
	 * Sets the pointer keyed to private_key for the current thread and the
	 * function notify to be called with that pointer (NULL or non-NULL),
	 * whenever the pointer is set again or whenever the current thread ends.
	 * This function also works, if g_thread_init() has not yet been
	 * called. If g_thread_init() is called later, the data keyed to
	 * private_key will be inherited only by the main thread, i.e. the one that
	 * called g_thread_init().
	 * Note
	 * notify is working quite differently from destructor in
	 * g_private_new().
	 * private_key:
	 * a GStaticPrivate.
	 * data:
	 * the new pointer.
	 * notify:
	 * a function to be called with the pointer, whenever the
	 * current thread ends or sets this pointer again.
	 */
	public void set(void* data, GDestroyNotify notify)
	{
		// void g_static_private_set (GStaticPrivate *private_key,  gpointer data,  GDestroyNotify notify);
		g_static_private_set(gStaticPrivate, data, notify);
	}
	
	/**
	 * Releases all resources allocated to private_key.
	 * You don't have to call this functions for a GStaticPrivate with an
	 * unbounded lifetime, i.e. objects declared 'static', but if you have a
	 * GStaticPrivate as a member of a structure and the structure is freed,
	 * you should also free the GStaticPrivate.
	 * private_key:
	 * a GStaticPrivate to be freed.
	 */
	public void free()
	{
		// void g_static_private_free (GStaticPrivate *private_key);
		g_static_private_free(gStaticPrivate);
	}
	
	
	
	
}