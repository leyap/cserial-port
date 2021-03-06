(cl:in-package :cserial-port)

(defclass serial-port ()
  ((name :initarg :name
	 :reader serial-port-name
	 :documentation "Device name")
   (fd :initarg :fd
       :reader serial-port-fd
       :documentation "opend handle")
   (encoding :initarg :encoding
	     :reader serial-port-encoding
	     :documentation "encoding")
   (baud-rate :initarg :baud-rate
	      :reader serial-port-baud-rate
	      :documentation "baud-rate")
   (databits :initarg :databits
	     :reader serial-port-databits
	     :documentation "Number of databits.")
   (stopbits :initarg :stopbits
	     :accessor serial-port-stopbits
	     :documentation "Number of stop-bits")
   (parity :initarg :parity
	   :accessor serial-port-parity
	   :documentation "Parity checking."))
  (:documentation ""))

(defvar *serial-port-class* 'serial-port)

(defmacro defgeneric% (fname params &key export doc)
  `(progn
     (defgeneric ,fname ,params
       (:method ((,(first params) t) ,@(rest params))
	 (error "not yet implemented method ~A for ~A"
		',fname (type-of ,(first params))))
       ,@(when doc `((:documentation ,doc))))
     ,@(when export
	     `((export ',fname)))))

;;convert to native form.
(defgeneric% %baud-rate (class &optional baud-rate))
(defgeneric% %databits (class &optional databits))
(defgeneric% %stopbits (class &optional stopbits))
(defgeneric% %parity (class &optional parity))

(defgeneric% %valid-fd-p (class))
(defgeneric% %set-invalid-fd (class))
(defgeneric% %input-available-p (class))
(defgeneric% %default-name (class &optional number))

(defgeneric% %close (class))
(defgeneric% %open (class &key))

(defgeneric% %write (class buf seq-size))
(defgeneric% %read  (class buf seq-size))
