package drive.web;

import java.io.ByteArrayOutputStream;
import java.io.PrintWriter;
import java.util.List;
import java.util.stream.Collectors;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.HttpStatus;

import drive.exceptions.DockNotFoundException;
import drive.model.Dock;
import drive.repository.DockRepository;

@Controller
@RequestMapping(path="/docks")
public class DockManagementController {
	private static final String FIELD_ERROR = "fieldError";

	private static final String ERROR_MESSAGE_LABEL = "errorMessage";

	final Integer DOCKS_LIMIT = 30;
	
	@Autowired
	DockRepository daoDock;
	
	@GetMapping(produces="text/html")
    public String getDocks(Model model) {
        System.out.println("GET Admin page");
        List<Dock> docks = daoDock.findAllByOrderByIdAsc();
        model.addAttribute("docks", docks);
        
        return "docks";
    }
	
	@GetMapping(path="/add.html", produces="text/html")
	public String addDockForm(Model model, @ModelAttribute Dock dock) {
		System.out.println("GET add.html");
		return "_add_dock";
	}
	
	@GetMapping(path="{id}/{id}_show_details.html", produces="text/html")
	public String show_dock_details(@PathVariable(name="id") int id, Model model) {
		System.out.println("show details");
		boolean isExist = daoDock.exists(id);
		if (isExist) {
			Dock d = daoDock.findById(id);
			model.addAttribute("dockDetails", d);
		}
		else 
			model.addAttribute(ERROR_MESSAGE_LABEL, "Error 404: The dock " + id + " not found !");
		return "_dock_details";
	}
	
	@PostMapping(path="/submit", produces="text/html")
	public String addDockSubmit(@ModelAttribute @Validated Dock dock, BindingResult result, Model model) {
		System.out.println("Submit dock ");
		if (!areValidFields(model, result, dock))
		    return "_add_dock";
		else {		
			long nbDocks = daoDock.count();
			if (nbDocks >= DOCKS_LIMIT) {
				String msg = String.format("Warning! limit(set at 30) is reached(actual number %d)", nbDocks);			
				model.addAttribute(ERROR_MESSAGE_LABEL, msg); 
				return "_add_dock";
			}
					
			List<Integer> docksOnArea = daoDock.findAllDocksIdOnArea(dock.getX(), 
			            dock.getY(), dock.getWidth(), dock.getLength());
			
			if (docksOnArea.isEmpty()) {
			    Dock addedDock = daoDock.save(dock);
	 	        model.addAttribute("newDock", String.format("The dock %d is added", addedDock.getId()));
	 	        dock.setId(null);
			}
			else {
			    String idOnCollision = docksOnArea.stream()
                                                  .map(id -> id.toString())
                                                  .collect(Collectors.joining(", "));
			    model.addAttribute(ERROR_MESSAGE_LABEL,
			                       String.format("Cannot add the dock because of collision with : %s", idOnCollision));
			}			
		}  
		return "_add_dock";
	}
	
	@GetMapping(path="/{id}/update", produces="text/html")
	public String updateDock(@PathVariable(name="id") int id, Model model, @ModelAttribute Dock dock) 
	        throws DockNotFoundException {
		System.out.println("Update dock");
		boolean isExist = daoDock.exists(id);
		if (isExist) {
			Dock dockToUpdate = daoDock.findById(id);
			model.addAttribute("toUpdate", dockToUpdate);
		}
		else {
		    throw new DockNotFoundException( String.format("The dock %d doesn't exist!", dock.getId()));
		}
		return "_update_dock";
	}
	
	@PostMapping(path="/{id}/confirmUpdate", produces="text/html")
	public String confirmUpdateDock(@PathVariable(name="id") int id, @ModelAttribute @Validated Dock dock, BindingResult result, Model model) 
	        throws DockNotFoundException {
		System.out.println("Put dock to confirm  ");
		boolean isExist = daoDock.exists(id);
		if (isExist) {
		    Dock docktoUpdate = daoDock.findOne(id);
			if (areValidFields(model, result, dock)) {    
				List<Integer> docksOnArea = daoDock.findAllDocksIdOnAreaExcludingADockId(dock.getX(), 
				        dock.getY(), dock.getWidth(), dock.getLength(), dock.getId());
				
				if (docksOnArea.isEmpty()) {
				    docktoUpdate.setX(dock.getX());
                    docktoUpdate.setY(dock.getY());
				    docktoUpdate.setWidth(dock.getWidth());
                    docktoUpdate.setLength(dock.getLength());
                    docktoUpdate.setFree(dock.isFree());
                    daoDock.save(docktoUpdate);
                    model.addAttribute("updateSuccess", "updated successfully");
				}
				else {	
				    String idOnCollision = docksOnArea.stream()
                                                      .map(d -> d.toString())
                                                      .collect(Collectors.joining(", "));
                    model.addAttribute("errorCollision",
                           String.format("Cannot update the dock %s because of collision with : %s",
                                         docktoUpdate.getId(), idOnCollision));
				    model.addAttribute("dockCollision", docksOnArea.get(0));				
				}
			}
			model.addAttribute("toUpdate", docktoUpdate);		
		}
		else {
		    throw new DockNotFoundException( String.format("The dock %d doesn't exist!", dock.getId()));
		}
		
		return "_update_dock";
	}
	
	@ResponseBody
	@DeleteMapping(path="/{id}/delete", produces="application/json")
	public String deleteDock(@PathVariable(name="id") int id, Model model) {
		System.out.println("Delete");JSONObject json = new JSONObject();
		if ((Integer) id != null ) {
			boolean isExist = daoDock.exists(id);
			if (isExist) {
				Dock dockToDelete = daoDock.findOne(id);
				daoDock.delete(dockToDelete.getId());
				json.put("message", String.format("The dock %d is deleted successfully !", dockToDelete.getId()));
			}
			else {
				json.put("message", String.format("Error: The dock %d doesn't exist!", id));
			}
		}
		else {
			json.put("message", "Error: A dock ID cannot be null");
		}
		return json.toString();
	}
	
	@ResponseBody
	@GetMapping(path="/docks_plane", produces="application/json")
	public String showDocksPlan(Model model) {
		System.out.println("GET docks_plan.html");
		
		List<Dock> docks = daoDock.findAll();
		JSONArray jArray = new JSONArray();
		docks.forEach(dock -> {
			JSONObject jObject = new JSONObject();
			
			jObject.put("id", dock.getId());
			jObject.put("x", dock.getX());
			jObject.put("y", dock.getY());
			jObject.put("width", dock.getWidth());
			jObject.put("length", dock.getLength());
			jObject.put("isFree", dock.isFree());
			
			jArray.put(jObject);
		});

		return jArray.toString();
	}
	
    private boolean areValidFields(Model model, BindingResult result, Dock dock) {   
        boolean isValid = false;
        
        if (result != null && result.hasFieldErrors()) 
            model.addAttribute(FIELD_ERROR, String.format("Error on field %s: must be a number", 
                                                result.getFieldError().getField().toString()));
        
        else if (dock.getLength() == null || dock.getWidth() == null) 
            model.addAttribute(ERROR_MESSAGE_LABEL, "Length and Width fields must be specified !");
        
        else if (dock.getLength() < 1 || dock.getWidth() < 1) 
            model.addAttribute(ERROR_MESSAGE_LABEL, "Length and Width values must be greater than zero !");
        
        else if (dock.getX() == null || dock.getY() == null)
            model.addAttribute(ERROR_MESSAGE_LABEL, "X-Position and Y-Position fields must be specified !");
        
        else if (dock.getX() < 0 || dock.getY() < 0) 
            model.addAttribute(ERROR_MESSAGE_LABEL, "X-Position and Y-Position values must be greater than zero !");
        
        else 
            isValid = true;
        
        return isValid;       
    }
	
	@ExceptionHandler(DockNotFoundException.class)
	@ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
	@ResponseBody
	public String dataExceptionHandler(Exception ex) {
		ByteArrayOutputStream out = new ByteArrayOutputStream();
		PrintWriter w = new PrintWriter( out );
		ex.printStackTrace(w);
		w.close();
		return 
			"ERROR 404 not found: " + ex.getMessage()
			+ "<!--\n" + out.toString() + "\n-->";
	}

}
 