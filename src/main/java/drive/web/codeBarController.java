package drive.web;

import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.hibernate.exception.DataException;
import org.krysalis.barcode4j.impl.upcean.EAN13Bean;
import org.krysalis.barcode4j.output.bitmap.BitmapCanvasProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import drive.mock.CommandeMockDao;
import drive.model.CommandMock;
import drive.model.CommandStatus;
import drive.model.Delivery;
import drive.model.Dock;
import drive.repository.DeliveryRepository;
import drive.repository.DockRepository;

@Controller
@RequestMapping(path = "/codeBar")
public class codeBarController {

    @Autowired
    DeliveryRepository deliveryDao;

    @Autowired
    CommandeMockDao commandDao;

    @Autowired
    DockRepository dockDao;

    private static BufferedImage generateEAN13BarcodeImage(String barcodeText) {
        EAN13Bean barcodeGenerator = new EAN13Bean();
        BitmapCanvasProvider canvas = new BitmapCanvasProvider(160, BufferedImage.TYPE_BYTE_BINARY, false, 0);
        barcodeGenerator.generateBarcode(canvas, barcodeText);
        return canvas.getBufferedImage();
    }

    private static String generateRandomCode() {
        Random random = new Random();
        char[] digits = new char[12];
        digits[0] = (char) (random.nextInt(9) + '1');
        for (int i = 1; i < 12; i++) {
            digits[i] = (char) (random.nextInt(10) + '0');
        }
        return new String(digits);
    }

    @RequestMapping(path = "/codeBarId/{codeBarId}", produces = { "image/jpeg" })
    public ResponseEntity<byte[]> getCodeBar(@PathVariable(name = "codeBarId") String code) throws IOException {
        BufferedImage codeBar;
        // generate codeBar from code
        codeBar = generateEAN13BarcodeImage(code);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(codeBar, "jpeg", baos);
        byte[] bytes = baos.toByteArray();
        final HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);
        return new ResponseEntity<byte[]>(bytes, headers, HttpStatus.CREATED);
    }

    @GetMapping(path = "/deliveryId/{id}.html", produces = "text/html")
    public String getPageCodeBar(@PathVariable(name = "id") Integer id, Model model) throws DataException {
        if (id <= 0)
            throw new DataException("id is inferior or equal to 0", null);
        Delivery delivery = deliveryDao.findById(id);
        if (delivery == null) {
            model.addAttribute("error", "Error while getting delivery.");
            return "redirect:/app/borne/user.html";
        }
        String codeBarId = generateRandomCode();
        // In case codeBarId is already been used
        while (deliveryDao.existsByCodeBarId(codeBarId))
            codeBarId = generateRandomCode();
        delivery.setCodeBarId(codeBarId);
        deliveryDao.save(delivery);
        model.addAttribute("delivery", delivery);
        return "codeBar";
    }

    @GetMapping(path = "/deliveryInfoRequest.html", produces = "text/html")
    public String getPageDeliveryInfoRequest(Model model) {
        return "deliveryInfoRequest";
    }

    @PostMapping(path = "submit")
    public String submit(HttpServletRequest request, Model model) {
        String code = request.getParameter("code");
        Delivery delivery = deliveryDao.findByCodeBarId(code);
        if (delivery != null) {
            model.addAttribute("delivery", delivery);
            return "redirect:/app/codeBar/deliveryInfo/deliveryId/" + delivery.getId() + ".html";
        } else {
            model.addAttribute("error", "The code sended is not in base. Please try again.");
        }
        return "redirect:/app/codeBar/deliveryInfoRequest.html";
    }

    @GetMapping(path = "/deliveryInfo/deliveryId/{id}.html", produces = "text/html")
    public String getPageDeliveryInfo(@PathVariable(name = "id") Integer id, Model model) {
        Delivery dev = deliveryDao.findById(id);
        model.addAttribute("delivery",dev);
        if (dev == null)
            return "redirect:/app/codeBar/deliveryInfoRequest.html";
        CommandMock cmd = commandDao.find(dev.getCommandId());
        if(cmd != null) model.addAttribute("command",cmd);
        return "deliveryInfo";
    }

    @PostMapping(path = "/validate/{id}")
    public String validateDelivery(@PathVariable(name = "id") Integer id, Model model) {
        Delivery delivery = deliveryDao.findById(id);
        if (delivery != null) {
            delivery.setStatus(CommandStatus.DELIVERED);
            deliveryDao.save(delivery);
            Dock dock = delivery.getDock();
            dock.setFree(true);
            dockDao.save(dock);
            model.addAttribute("delivery", delivery);
        } else {
            model.addAttribute("error",
                    "An error as occured during the validation of the delivery : delivery can't be found");
        }
        return "redirect:/app/codeBar/deliveryInfo/deliveryId/{id}.html";
    }
}
